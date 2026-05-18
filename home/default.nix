{ pkgs, ... }:

{
  imports = [
    ./ssh.nix
    ./zsh.nix
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bat
    beekeeper-studio
    bitwarden-desktop
    bruno
    cargo
    curl
    docker
    eza
    fastfetch
    fd
    filezilla
    fzf
    gcc
    gnumake
    go
    htop
    jq
    lazygit
    librewolf
    llama-cpp
    llama-swap
    ncdu
    nodejs_24
    obsidian
    opencode
    openssl
    pkg-config
    ripgrep
    rustc
    shellcheck
    starship
    television
    tldr
    tree
    unzip
    wezterm
    wget
    yazi
    zed-editor
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
