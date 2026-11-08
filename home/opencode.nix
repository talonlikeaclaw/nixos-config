{ lib, pkgs, ... }:

{
  xdg.configFile."opencode/config.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    provider = {
      unsloth = {
        npm = "@ai-sdk/openai-compatible";
        name = "Unsloth Studio";
        options = {
          baseURL = "http://192.168.0.30:8888/v1";
          apiKey = "{env:UNSLOTH_STUDIO_AUTH_TOKEN}";
        };
        models = {
          "mudler/KAT-Coder-V2.5-Dev-APEX-GGUF" = {
            name = "KAT-Coder V2.5 Dev APEX";
            limit = {
              context = 262144;
              output = 4096;
            };
          };
        };
      };
    };
    mcp = {
      context7 = {
        command = [
          "npx"
          "@upstash/context7-mcp"
        ];
        type = "local";
        enabled = true;
      };
      time = {
        command = [
          "npx"
          "-y"
          "@guanxiong/mcp-server-time"
        ];
        type = "local";
        enabled = true;
      };
    };
    permission = {
      websearch = "allow";
      skill = "deny";
    };
    share = "disabled";
  };

  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    plugin = [
      "@dietrichgebert/ponytail"
    ];
    mcp = {
      engram = {
        command = [
          "engram"
          "mcp"
          "--tools=agent"
        ];
        enabled = true;
        type = "local";
      };
    };
  };

  xdg.configFile."opencode/package.json".text = builtins.toJSON {
    dependencies = {
      "@opencode-ai/plugin" = "1.19.5";
    };
  };

  # OpenCode 2.x keeps TUI settings in cli.json and only migrates the legacy
  # tui.json once. Herdr rewrites the TUI plugin list at activation time, so
  # seed a writable regular file instead of linking a store path that Herdr
  # refuses to edit.
  home.activation.installOpencodeCliConfig = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    config="$HOME/.config/opencode/cli.json"

    if [ ! -e "$config" ]; then
      mkdir -p "$(dirname "$config")"
      cat > "$config" <<'EOF'
{
  "$schema": "https://opencode.ai/v2/cli.json",
  "plugins": [
    "opencode-subagent-statusline"
  ]
}
EOF
      chmod u+w "$config"
    fi
  '';

  xdg.configFile."opencode-plugins-engram" = {
    target = "opencode/plugins/engram.ts";
    source = ./opencode/engram.ts;
  };

  xdg.configFile."opencode-skills" = {
    target = "opencode/skills";
    source = ./opencode/skills;
  };

  home.activation.setupOpencodePlugins = ''
    cd "$HOME/.config/opencode"

    if [ ! -f node_modules/@opencode-ai/plugin/package.json ] ||
      [ "$(${pkgs.jq}/bin/jq -r .version node_modules/@opencode-ai/plugin/package.json)" != "1.19.5" ]; then
      ${pkgs.bun}/bin/bun install
    fi
  '';
}
