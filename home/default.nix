{ pkgs, ... }:

{
  imports = [ ./ssh.nix ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bar
    curl
    eza
    fastfetch
    fd
    fzf
    htop
    jq
    lazygit
    ripgrep
    tldr
    tree
    wget
    zoxide
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "talonlikeaclaw";
      user.email = "talonlikeaclaw@proton.me";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
  };
}
