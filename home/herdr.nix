{
  herdr,
  lib,
  pkgs,
  ...
}:

let
  herdrPackage = herdr.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [ herdrPackage ];

  xdg.configFile."herdr/config.toml".text = ''
    # Herdr is managed by Nix; upgrade it by updating the pinned flake input.
    onboarding = false

    [theme]
    name = "catppuccin"

    [terminal]
    new_cwd = "follow"

    [keys]
    prefix = "ctrl+a"
    reload_config = "prefix+r"
    resize_mode = "prefix+shift+r"
    focus_pane_left = ["prefix+h", "alt+left"]
    focus_pane_down = ["prefix+j", "alt+down"]
    focus_pane_up = ["prefix+k", "alt+up"]
    focus_pane_right = ["prefix+l", "alt+right"]
    previous_tab = ["prefix+p", "shift+left", "alt+shift+h"]
    next_tab = ["prefix+n", "shift+right", "alt+shift+l"]
    rename_tab = "prefix+shift+,"

    [[keys.command]]
    key = "prefix+f"
    type = "plugin_action"
    command = "herdr-file-viewer.open-file-viewer"
    description = "open file viewer in split"

    [[keys.command]]
    key = "prefix+shift+f"
    type = "plugin_action"
    command = "herdr-file-viewer.open-file-viewer-tab"
    description = "open file viewer in tab"

    [[keys.command]]
    key = "ctrl+h"
    type = "plugin_action"
    command = "herdr-splits.nav-left"

    [[keys.command]]
    key = "ctrl+j"
    type = "plugin_action"
    command = "herdr-splits.nav-down"

    [[keys.command]]
    key = "ctrl+k"
    type = "plugin_action"
    command = "herdr-splits.nav-up"

    [[keys.command]]
    key = "ctrl+l"
    type = "plugin_action"
    command = "herdr-splits.nav-right"

    [[keys.command]]
    key = "ctrl+left"
    type = "plugin_action"
    command = "herdr-splits.resize-left"

    [[keys.command]]
    key = "ctrl+down"
    type = "plugin_action"
    command = "herdr-splits.resize-down"

    [[keys.command]]
    key = "ctrl+up"
    type = "plugin_action"
    command = "herdr-splits.resize-up"

    [[keys.command]]
    key = "ctrl+right"
    type = "plugin_action"
    command = "herdr-splits.resize-right"

    [[keys.command]]
    key = "prefix+shift+t"
    type = "plugin_action"
    command = "fullerzz.sesh.open-picker"
    description = "open Sesh picker"

    [[keys.command]]
    key = "prefix+shift+b"
    type = "plugin_action"
    command = "fullerzz.sesh.last"
    description = "switch to previous Sesh workspace"

    [session]
    resume_agents_on_restore = true

    [update]
    version_check = false
  '';

  # Keep the bundled OpenCode integration in lockstep with the pinned binary.
  home.activation.installHerdrOpenCodeIntegration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${herdrPackage}/bin/herdr integration install opencode
  '';

  home.activation.installHerdrPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${lib.makeBinPath [
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
    ]}:$PATH"

    run ${herdrPackage}/bin/herdr plugin install smarzban/herdr-file-viewer --ref v1.14.0 --yes
    run ${herdrPackage}/bin/herdr plugin install lmilojevicc/herdr-splits.nvim --ref v0.5.1 --yes
    run ${herdrPackage}/bin/herdr plugin install fullerzz/herdr-plugin-sesh --ref v0.6.0 --yes
  '';
}
