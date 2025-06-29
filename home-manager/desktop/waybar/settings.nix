_: {
  # https://github.com/ashish-kus/waybar-minimal/blob/main/src/config.jsonc
  # Options: https://github.com/Alexays/Waybar/wiki/Configuration
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      modules-left = [
        "custom/logo"
        "hyprland/workspaces"
        "group/monitoring"
        "network#speed"
      ];
      modules-center = [
        "clock"
        #"cava"
      ];
      modules-right = [
        "group/media"
        "tray"
        #"hyprland/window"
        "group/actions"
        "group/system"
        "custom/notifications"
      ];
    };
  };
}
