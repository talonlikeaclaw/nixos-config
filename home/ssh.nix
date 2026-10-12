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
      # Homelab: Proxmox node and service LXCs (.200-.252), root over the
      # unified Vaultwarden key.
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
