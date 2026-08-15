import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const destructiveCommandPatterns = [
  /\brm\b/i,
  /\bsudo\b/i,
  /\b(chmod|chown|mkfs|dd|shutdown|reboot|poweroff|halt)\b/i,
  /\bgit\b[^\n]*(?:\bpush\b[^\n]*\s(?:--force(?:-with-lease)?|-f)\b|\breset\s+--hard\b|\bclean\b[^\n]*\s-f)/i,
];

function preview(text: string, limit = 8_000): string {
  return text.length <= limit
    ? text
    : `${text.slice(0, limit)}\n\n[Preview truncated]`;
}

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event, ctx) => {
    if (event.toolName === "write" || event.toolName === "edit") {
      if (!ctx.hasUI) {
        return {
          block: true,
          reason:
            "File mutation blocked: confirmation requires an interactive UI",
        };
      }

      const input = event.input as {
        path: string;
        content?: string;
        edits?: Array<{ oldText: string; newText: string }>;
      };
      const change =
        event.toolName === "write"
          ? (input.content ?? "")
          : (input.edits ?? [])
              .map(
                (edit, index) =>
                  `Edit ${index + 1}:\n- ${edit.oldText}\n+ ${edit.newText}`,
              )
              .join("\n\n");
      const allowed = await ctx.ui.confirm(
        `Allow ${event.toolName}?`,
        `${input.path}\n\n${preview(change)}`,
      );

      if (!allowed)
        return { block: true, reason: "File mutation declined by user" };
      return;
    }

    if (event.toolName !== "bash") return;

    const command = (event.input as { command: string }).command;
    if (!destructiveCommandPatterns.some((pattern) => pattern.test(command)))
      return;

    if (!ctx.hasUI) {
      return {
        block: true,
        reason:
          "Destructive command blocked: confirmation requires an interactive UI",
      };
    }

    const allowed = await ctx.ui.confirm(
      "Allow destructive command?",
      preview(command),
    );
    if (!allowed)
      return { block: true, reason: "Destructive command declined by user" };
  });
}
