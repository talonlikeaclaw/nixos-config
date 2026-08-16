{ lib, pkgs, ... }:

let
  little-coder = pkgs.buildNpmPackage {
    pname = "little-coder";
    version = "1.17.0";

    src = pkgs.fetchFromGitHub {
      owner = "itayinbarr";
      repo = "little-coder";
      rev = "v1.17.0";
      hash = "sha256-x5l6g0PzSkNlf/vQOZczyHZjs5YamfKnYm1dcH6uMg4=";
    };

    dontNpmBuild = true;
    npmDepsFetcherVersion = 2;
    npmDepsHash = "sha256-Go9rGJfXFhG6V/vBjA67SC43xb1CJoFbf20kuYrMjuM=";

    installPhase = ''
      runHook preInstall
      npm pack --ignore-scripts
      npm install -g --offline --prefix "$out" little-coder-*.tgz
      runHook postInstall
    '';
  };
in
{
  home.packages = [ little-coder ];

  xdg.configFile."little-coder/models.json".text = builtins.toJSON {
    default = "unsloth/mudler/KAT-Coder-V2.5-Dev-APEX-GGUF";
    providers.unsloth = {
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
          contextWindow = 262144;
          maxTokens = 4096;
          cost = {
            input = 0;
            output = 0;
            cacheRead = 0;
            cacheWrite = 0;
          };
        }
        {
          id = "unsloth/Qwen3.8-27B-GGUF";
          name = "Qwen3.8 27B";
          reasoning = true;
          input = [ "text" "image" ];
          contextWindow = 64256;
          maxTokens = 4096;
          compat.thinkingFormat = "qwen";
        }
        {
          id = "unsloth/Laguna-S-2.1-GGUF";
          name = "Laguna S 2.1";
          reasoning = true;
          input = [ "text" ];
          contextWindow = 64256;
          maxTokens = 4096;
          compat.thinkingFormat = "qwen-chat-template";
        }
      ];
    };
  };
}
