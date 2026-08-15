{ pkgs, ... }:

{
  home.packages = [ pkgs.pi-coding-agent ];

  home.file = {
    ".pi/agent/settings.json".text = builtins.toJSON {
      theme = "dark";
      defaultProvider = "openai-codex";
      defaultModel = "gpt-5.6-terra";
      defaultThinkingLevel = "medium";
      defaultProjectTrust = "ask";
      enableInstallTelemetry = false;
      enabledModels = [
        "openai-codex/gpt-5.6-terra:medium"
        "opencode/gpt-5.6-terra:medium"
        "openrouter/openai/gpt-5.6-terra:medium"
        "unsloth/mudler/KAT-Coder-V2.5-Dev-APEX-GGUF:off"
      ];
      packages = [
        "npm:@gotgenes/pi-permission-system@25.3.0"
        "npm:pi-web-access@0.23.0"
        "npm:@dietrichgebert/ponytail@4.9.0"
        "npm:pi-open-tui@0.2.12"
        "npm:pi-hermes-memory@0.9.5"
        "npm:pi-lens@4.0.0"
        "npm:pi-subagents@0.50.0"
        "npm:pi-markdown-preview@0.14.1"
      ];
    };

    ".pi/web-search.json".text = builtins.toJSON {
      workflow = "none";
    };

    ".pi/agent/AGENTS.md".text = ''
      # Global Pi Instructions

      Follow the repository's instructions and conventions before these general preferences.

      - Inspect relevant code and documentation before changing files.
      - Make focused changes; do not refactor unrelated code.
      - Run the project's relevant validation after changes and report what ran.
      - Do not expose, modify, or commit secrets unless explicitly asked.
    '';

    ".pi/agent/keybindings.json".text = builtins.toJSON {
      "app.model.cycleForward" = "ctrl+n";
      "app.model.cycleBackward" = "ctrl+p";
    };

    ".pi/agent/prompts/plan.md".text = ''
      ---
      description: Investigate a task and propose an implementation plan without editing files
      argument-hint: "<task>"
      ---
      Investigate this task and produce a concise implementation plan: $@

      Do not modify files. First inspect the relevant code, configuration, tests, and project instructions. State affected files, the proposed changes, validation commands, and any assumptions or risks.
    '';

    ".pi/agent/prompts/review.md".text = ''
      ---
      description: Review the current working-tree changes for correctness and regressions
      argument-hint: "[focus]"
      ---
      Review the current working-tree changes. Focus instructions: $@

      Inspect the diff and the relevant surrounding code. Report findings ordered by severity, with file and line references. Focus on correctness, security, error handling, tests, and regressions. Do not modify files.
    '';

    ".pi/agent/prompts/implement.md".text = ''
      ---
      description: Implement a task carefully and validate the result
      argument-hint: "<task>"
      ---
      Implement this task: $@

      Read the relevant project instructions and existing code first. Make the smallest correct change, run appropriate validation, and summarize the changes and validation results.
    '';

    ".pi/agent/skills".source = ./opencode/skills;
    ".pi/agent/extensions/pi-permission-system/config.json".text = builtins.toJSON {
      "$schema" = "https://raw.githubusercontent.com/gotgenes/pi-packages/main/packages/pi-permission-system/schemas/permissions.schema.json";
      permissionReviewLog = false;
      yoloMode = false;
      doublePressToConfirm = true;
      permission = {
        "*" = "allow";
        path = {
          "*" = "allow";
          "*.env" = "deny";
          "*.env.*" = "deny";
          "*.env.example" = "allow";
          ".git" = "deny";
          ".git/*" = "deny";
          "*/.git/*" = "deny";
          "*secrets*" = "deny";
          "*credential*" = "deny";
          "*password*" = "deny";
          "*passwd*" = "deny";
          "*.pem" = "deny";
          "*.key" = "deny";
          "*.p12" = "deny";
          "*.pfx" = "deny";
          "~/.ssh/*" = "deny";
          "/etc/ssh/*" = "deny";
          "/nix/store/*" = "deny";
          "/run/secrets/*" = "deny";
        };
        read = "allow";
        write = "ask";
        edit = "ask";
        bash = {
          "*" = "allow";
          "git *" = "ask";
          "git status *" = "allow";
          "git diff *" = "allow";
          "git log *" = "allow";
          "git show *" = "allow";
          "git rev-parse *" = "allow";
          "git ls-files *" = "allow";
          "rm *" = "ask";
          "sudo *" = "ask";
          "chmod *" = "ask";
          "chown *" = "ask";
          "mkfs *" = "ask";
          "dd *" = "ask";
          "shutdown *" = "ask";
          "reboot *" = "ask";
          "poweroff *" = "ask";
          "halt *" = "ask";
        };
        mcp = "ask";
        external_directory = "ask";
      };
    };

    ".pi/agent/models.json".text = builtins.toJSON {
      providers = {
        openrouter = {
          models = [
            {
              id = "openai/gpt-5.6-terra";
              name = "GPT-5.6 Terra";
              reasoning = true;
              input = [
                "text"
                "image"
              ];
              contextWindow = 272000;
              maxTokens = 128000;
            }
          ];
        };

        unsloth = {
          name = "Unsloth Studio";
          api = "openai-completions";
          baseUrl = "http://192.168.0.30:8888/v1";
          apiKey = "$UNSLOTH_STUDIO_AUTH_TOKEN";
          models = [
            {
              id = "mudler/KAT-Coder-V2.5-Dev-APEX-GGUF";
              name = "KAT-Coder V2.5 Dev APEX";
              reasoning = false;
              input = [ "text" ];
              cost = {
                input = 0;
                output = 0;
                cacheRead = 0;
                cacheWrite = 0;
              };
              contextWindow = 262144;
              maxTokens = 4096;
            }
          ];
        };
      };
    };
  };
}
