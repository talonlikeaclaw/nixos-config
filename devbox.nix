# Headless NixOS configuration for Proxmox devbox

{ pkgs, ... }:

{
  imports =
    [
      ./devbox-hardware.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

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
    extraGroups = [ "networkmanager" "wheel" "docker" ];
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
    };
    openFirewall = true;
  };

  # Enable Tailscale
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  # Enable GPG agent with SSH support
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Open ports in the firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Disable the firewall
  # networking.firewall.enable = false;

  # NixOS Version
  system.stateVersion = "25.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
