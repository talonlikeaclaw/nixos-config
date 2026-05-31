{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme = "breeze-dark";
      cursor = {
        theme = "Breeze_Snow";
        size = 24;
      };
    };

    panels = [
      {
        location = "bottom";
        widgets = [
          {
            kickoff = {
              icon = "nix-snowflake-white";
            };
          }
          {
            iconTasks = {
              launchers = [
                "applications:systemsettings.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:librewolf.desktop"
                "applications:obsidian.desktop"
                "applications:bruno.desktop"
                "applications:beekeeper-studio.desktop"
                "applications:filezilla.desktop"
                "applications:bitwarden.desktop"
                "applications:dev.zed.Zed.desktop"
                "applications:org.wezfurlong.wezterm.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
            };
          }
          {
            digitalClock = {
              time.format = "24h";
            };
          }
        ];
      }
    ];
  };
}