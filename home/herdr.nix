{
  herdr,
  lib,
  pkgs,
  dotfiles,
  ...
}:

let
  herdrPackage = herdr.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [ herdrPackage ];

  xdg.configFile."herdr/config.toml".source = "${dotfiles}/herdr/.config/herdr/config.toml";

  # Keep the bundled OpenCode integration in lockstep with the pinned binary.
  home.activation.installHerdrOpenCodeIntegration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${herdrPackage}/bin/herdr integration install opencode
  '';

  home.activation.installHerdrPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${
      lib.makeBinPath [
        pkgs.bash
        pkgs.coreutils
        pkgs.cargo
        pkgs.curl
        pkgs.gawk
        pkgs.gcc
        pkgs.git
        pkgs.git-lfs
        pkgs.go
        pkgs.rustc
      ]
    }:$PATH"

    run ${herdrPackage}/bin/herdr plugin install smarzban/herdr-file-viewer --ref v1.14.0 --yes
    run ${herdrPackage}/bin/herdr plugin install lmilojevicc/herdr-splits.nvim --ref v0.5.1 --yes
    run ${herdrPackage}/bin/herdr plugin install fullerzz/herdr-plugin-sesh --ref v0.6.0 --yes
  '';
}
