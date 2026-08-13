{ pkgs, ... }:

let
  engramPlugin = pkgs.writeTextDir "plugins/engram.ts" (builtins.readFile ./opencode/engram.ts);
in
{
  xdg.configFile."opencode/config.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    provider = {
      "llama.cpp" = {
        npm = "@ai-sdk/openai-compatible";
        name = "llama.cpp (host)";
        options = {
          baseURL = "http://192.168.0.143:8080/v1";
        };
        models = {
          "qwen3.6-35b" = {
            name = "Qwen3.6 35B-A3B Q4_K_XL";
            limit = {
              context = 131072;
              output = 32768;
            };
          };
        };
      };
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
              context = 65536;
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
      weather = {
        type = "remote";
        url = "http://127.0.0.1:8812/mcp";
        enabled = false;
      };
      dockerhub = {
        type = "remote";
        url = "http://127.0.0.1:8814/sse";
        enabled = false;
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
      "@opencode-ai/plugin" = "1.18.16";
    };
  };

  xdg.configFile."opencode/tui.json".text = builtins.toJSON {
    plugin = [
      "opencode-subagent-statusline"
    ];
  };

  xdg.configFile."opencode-plugins-engram" = {
    target = "opencode/plugins/engram.ts";
    source = "${engramPlugin}/plugins/engram.ts";
  };

  xdg.configFile."opencode-skills" = {
    target = "opencode/skills";
    source = ./opencode/skills;
  };

  home.activation.setupOpencodePlugins = ''
    cd "$HOME/.config/opencode"

    if [ ! -f node_modules/@opencode-ai/plugin/package.json ] ||
      [ "$(${pkgs.jq}/bin/jq -r .version node_modules/@opencode-ai/plugin/package.json)" != "1.18.16" ]; then
      ${pkgs.bun}/bin/bun install
    fi
  '';
}
