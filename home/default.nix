{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./ssh.nix
    ./starship.nix
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
    fastfetch
    fd
    filezilla
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
    television
    tldr
    tree
    unzip
    wezterm
    wget
    yazi
    zed-editor
    
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "talonlikeaclaw";
      user.email = "talonlikeaclaw@proton.me";
    };
  };

  programs.zoxide = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
  };
}
