{ pkgs, ... }:

let
  engram = pkgs.buildGoModule {
    name = "engram";
    src = pkgs.fetchFromGitHub {
      owner = "Gentleman-Programming";
      repo = "engram";
      rev = "v1.15.15";
      hash = "sha256-QtR90b16BC+dVRQFNZy0pAXoX0hb0MCX7ZnIr7JsCNQ=";
    };
    vendorHash = "sha256-O+pC4x4DKNUWr7Sx9iZOjK6a64wrQA4/lnjvkNLBX64=";
    ldflags = [
      "-s"
      "-w"
      "-X main.version=v1.15.15"
    ];
    subPackages = [ "cmd/engram" ];
    doCheck = false;
  };
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./fastfetch.nix
    ./opencode.nix
    ./ssh.nix
    ./starship.nix
    ./wezterm.nix
    ./zsh.nix
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    beekeeper-studio
    bitwarden-desktop
    bruno
    bun
    cargo
    curl
    docker
    engram
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

  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
  };

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
