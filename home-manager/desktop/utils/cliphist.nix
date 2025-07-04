{ pkgs, ... }:
{
  # Clipboard manager
  home.packages = with pkgs; [ cliphist ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "wl-paste --type text --watch cliphist store" # Stores only text data

    "wl-paste --type image --watch cliphist store" # Stores only image data
  ];
}
