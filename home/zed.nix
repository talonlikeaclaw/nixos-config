{ ... }:

{
  home.sessionVariables.ZED_ALLOW_EMULATED_GPU = "1";
  xdg.configFile."zed/settings.json" = {
    source = ./zed/settings.json;
  };

  xdg.configFile."zed/keymap.json" = {
    source = ./zed/keymap.json;
  };

  xdg.configFile."zed/tasks.json" = {
    source = ./zed/tasks.json;
  };
}