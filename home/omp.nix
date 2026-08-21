{ dotfiles, lib, pkgs, ... }:

let
  omp = pkgs.stdenvNoCC.mkDerivation {
    pname = "omp";
    version = "17.4.2";
    src = pkgs.fetchurl {
      url = "https://github.com/can1357/oh-my-pi/releases/download/v17.4.2/omp-linux-x64";
      hash = "sha256-IYqGhMKxEla0fii6ExrfsqA+mI7d2FZ72Da3xR3QIAU=";
    };
    dontUnpack = true;
    installPhase = ''
      install -Dm755 "$src" "$out/bin/omp"
    '';
  };
in
{
  home.packages = [ omp ];

  home.file = lib.optionalAttrs (builtins.pathExists "${dotfiles}/omp/.omp/agent/mcp.json") {
    ".omp/agent/mcp.json".source = "${dotfiles}/omp/.omp/agent/mcp.json";
  };

  # OMP writes preferences atomically; a Home Manager source link points into
  # /nix/store and therefore cannot serve as its live configuration file.
  home.activation.installOmpConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config="$HOME/.omp/agent/config.yml"

    if [ -L "$config" ]; then
      rm "$config"
    fi

    if [ ! -e "$config" ]; then
      mkdir -p "$(dirname "$config")"
      cp "${dotfiles}/omp/.omp/agent/config.yml" "$config"
      chmod u+w "$config"
    fi
  '';
}
