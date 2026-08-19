{ dotfiles, lib, pkgs, ... }:

let
  omp = pkgs.stdenvNoCC.mkDerivation {
    pname = "omp";
    version = "17.3.8";
    src = pkgs.fetchurl {
      url = "https://github.com/can1357/oh-my-pi/releases/download/v17.3.8/omp-linux-x64";
      hash = "sha256-79tU8AVOgK/hwFwJ9D1c7QnOjsi3XD+2sMpc5IBbOD8=";
    };
    dontUnpack = true;
    installPhase = ''
      install -Dm755 "$src" "$out/bin/omp"
    '';
  };
in
{
  home.packages = [ omp ];

  home.file = {
    ".omp/agent/config.yml".source = "${dotfiles}/omp/.omp/agent/config.yml";
  } // lib.optionalAttrs (builtins.pathExists "${dotfiles}/omp/.omp/agent/mcp.json") {
    ".omp/agent/mcp.json".source = "${dotfiles}/omp/.omp/agent/mcp.json";
  };
}
