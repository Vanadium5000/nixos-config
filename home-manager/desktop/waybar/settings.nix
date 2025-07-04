{ config, ... }:
let
  thme = config.var.theme;
in
{
  # https://github.com/ashish-kus/waybar-minimal/blob/main/src/config.jsonc
  # Options: https://github.com/Alexays/Waybar/wiki/Configuration
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      margin-top = thme.gaps-out;
      margin-left = thme.gaps-out;
      margin-right = thme.gaps-out;

      modules-left = [
        "custom/logo"
        "hyprland/workspaces"
        "tray"
        "group/actions"
        "group/monitoring"
        "network#speed"
      ];
      modules-center = [
        "clock"
        #"custom/lyrics"
        #"cava"
      ];
      modules-right = [
        "custom/recording"
        "group/media"
        #"hyprland/window"
        "group/system"
        "custom/notifications"
      ];
    };
  };
}
