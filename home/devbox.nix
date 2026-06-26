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
    ./lazygit.nix
    ./nvim.nix
    ./opencode.nix
    ./ssh.nix
    ./starship.nix
    ./television.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ansible
    bun
    cargo
    convco
    curl
    deadnix
    docker
    engram
    nix-output-monitor
    nix-tree
    fd
    gcc
    gh
    gitmux
    gnumake
    go
    docker-compose
    htop
    jq
    ncdu
    nh
    nodejs_24
    opencode
    openssl
    opentofu
    pkg-config
    pgcli
    python3
    ripgrep
    rustc
    sqlite
    shellcheck
    sesh
    television
    tldr
    tmux
    tree
    unzip
    wget
    yazi
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
      init.defaultBranch = "main";
      diff.colorMoved = "default";
    };

    lfs.enable = true;

    ignores = [
      "*.swp"
      "*.swo"
      "*~"
      "#*#"
      "*.log"
      ".direnv/"
      ".envrc"
      ".env*"
      "node_modules/"
      ".idea/"
      ".vscode/"
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
      syntax-theme = "Catppuccin Mocha";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.btop = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.lazydocker = {
    enable = true;
  };

  xdg.configFile."pgcli/config".text = ''
    [main]
    smart_completion = True
    multi_line = False
    multi_line_mode = psql
    destructive_warning = drop, shutdown, delete, truncate, alter, update, unconditional_update
    keyring = True
    row_limit = 1000

    [alias_dsn]
    dev = postgresql://talonlikeaclaw@192.168.0.212:5432/postgres?client_encoding=utf8
  '';
}