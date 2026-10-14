{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/github";
      };
      "gitlab.com" = {
        HostName = "gitlab.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519_gitlab";
      };
      "truenas" = {
        HostName = "truenas-scale";
        User = "talon";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "macbook" = {
        HostName = "talons-macbook-pro";
        User = "talon";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "endeavouros" = {
        User = "talon";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "vps-mtl" = {
        User = "talon";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "proxmox" = {
        HostName = "192.168.0.112";
        User = "root";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "192.168.0.112" = {
        User = "root";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "192.168.0.2*" = {
        User = "root";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
