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

    [session]
    resume_agents_on_restore = true

    [update]
    version_check = false
  '';

  # Keep the bundled OpenCode integration in lockstep with the pinned binary.
  home.activation.installHerdrOpenCodeIntegration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${herdrPackage}/bin/herdr integration install opencode
  '';
}
