# Headless NixOS configuration for Proxmox devbox

{ pkgs, ... }:

{
  imports = [
    ./devbox-hardware.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable serial console for Proxmox VNC fallback
  boot.kernelParams = [ "console=ttyS0,115200n8" ];
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking.hostName = "devbox";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Define user account
  users.users.talon = {
    isNormalUser = true;
    description = "Talon";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL2Lj+2jCHag/Xk/do2laBTiGFxW6ilZ1XkYiPDSYFIw talonlikeaclaw@proton.me"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILnRJjVRxTLklHTulR9+ZxSvbNMERzoQuUdLCJmsXtHE talon@macbook"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHuakRF15pYHCmXHc9l0njV/sHZvEWaF2HaKbTBvcHN6 talon@termius"
    ];
  };

  # Install zsh shell
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    git
    tailscale
  ];

  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable SSH with hardening
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      AcceptEnv = [
        "COLORTERM"
        "TERM_PROGRAM"
      ];
    };
    openFirewall = true;
  };

  # Enable Tailscale
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  programs.ssh.startAgent = true;

  # Run prebuilt dynamic binaries (codium-server downloaded by the
  # open-remote-ssh VSCodium extension) on NixOS.
  programs.nix-ld = {
    enable = true;
    libraries = [ pkgs.icu ];
  };

  # Open ports in the firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Disable the firewall
  # networking.firewall.enable = false;

  # NixOS Version
  system.stateVersion = "25.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
