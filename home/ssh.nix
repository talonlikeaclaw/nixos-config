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
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "gitlab.com" = {
        HostName = "gitlab.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519_gitlab";
      };
    };
  };
}
