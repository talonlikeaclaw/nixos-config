{ ... }:

{
  xdg.configFile."television/config.toml" = {
    source = ./television/config.toml;
  };

  xdg.configFile."television/cable/ssh-hosts.toml" = {
    source = ./television/cable/ssh-hosts.toml;
  };
  xdg.configFile."television/cable/bash-history.toml" = {
    source = ./television/cable/bash-history.toml;
  };
  xdg.configFile."television/cable/procs.toml" = {
    source = ./television/cable/procs.toml;
  };
  xdg.configFile."television/cable/systemd-units.toml" = {
    source = ./television/cable/systemd-units.toml;
  };
  xdg.configFile."television/cable/zsh-history.toml" = {
    source = ./television/cable/zsh-history.toml;
  };
}