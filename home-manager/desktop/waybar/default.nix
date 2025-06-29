{pkgs, ...}: {
  imports = [
    ./scripts
    ./modules

    ./settings.nix
    ./style.nix
  ];

  # Highly customizable Wayland bar for Sway and Wlroots based compositors
  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };

  # Start waybar when Hyprland starts
  #wayland.windowManager.hyprland.settings.exec-once = ["waybar"];

  # Used by waybar config
  home.packages = with pkgs; [
    pavucontrol
    alsa-utils
    pulseaudio
  ];
}
