{ dotfiles, lib, pkgs, ... }:

let
  omp = pkgs.stdenvNoCC.mkDerivation {
    pname = "omp";
    version = "17.3.7";
    src = pkgs.fetchurl {
      url = "https://github.com/can1357/oh-my-pi/releases/download/v17.3.7/omp-linux-x64";
      hash = "sha256-TubtKDvhAhHUc+ndRbEn8iKYIN8+JyKlowW5p/l364M=";
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
