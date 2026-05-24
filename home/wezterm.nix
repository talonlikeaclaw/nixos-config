{ pkgs, ... }:

{
  home.packages = with pkgs; [
    maple-mono.NF
  ];

  xdg.configFile."wezterm/wezterm.lua" = {
    source = ./wezterm/wezterm.lua;
  };

  xdg.configFile."wezterm/sessions/mainframe.lua" = {
    source = ./wezterm/sessions/mainframe.lua;
  };
}