{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./scripts
    ./modules

    ./settings-new.nix

    ./style-new.nix
  ];

  # Highly customizable Wayland bar for Sway and Wlroots based compositors
  programs.waybar = {
    enable = true;
  };

  # Start waybar when Hyprland starts
  wayland.windowManager.hyprland.settings.exec-once = ["waybar"];

  # Used by waybar config
  home.packages = with pkgs; [
    pavucontrol
    alsa-utils
    pulseaudio
  ];
}
