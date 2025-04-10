_: {
  # https://github.com/gzowski/public_configs/blob/main/.config/waybar/config
  # Options: https://github.com/Alexays/Waybar/wiki/Configuration
  programs.waybar.settings = {
    mainBar = {
      position = "top";
      layer = "top";
      modules-left = [
        "custom/os_button"
        "clock"
        "mpris"
      ];
      modules-center = [
        "hyprland/workspaces"
      ];
      modules-right = [
        "tray"
        "pulseaudio"
        "disk"
      ];

      reload_style_on_change = true;
    };
  };
}
