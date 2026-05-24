{ ... }:

{
  xdg.configFile."opencode/config.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    provider = {
      "llama.cpp" = {
        npm = "@ai-sdk/openai-compatible";
        name = "llama.cpp (local)";
        options = {
          baseURL = "http://127.0.0.1:12434/v1";
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
    };
    mcp = {
      context7 = {
        type = "remote";
        url = "http://127.0.0.1:8811/sse";
        enabled = true;
      };
      time = {
        type = "remote";
        url = "http://127.0.0.1:8813/sse";
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
    };
    share = "disabled";
  };

  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
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
}