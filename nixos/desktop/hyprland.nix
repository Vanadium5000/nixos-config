{
  pkgs,
  inputs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl # Display brightness controls
    playerctl # Pause,package = inputs.hyprland.packages.${pkgs.system}.hyprland; Play, etc. player controls

    grimblast # Screenshot utility
    tesseract # Image to text cli

    nwg-dock-hyprland # App dock
    nwg-drawer # Full-screen application launcher
  ];

  # XDG Portal
  xdg.portal = {
    enable = true;
    config.common.default = "gtk";
    xdgOpenUsePortal = true;

    extraPortals = with pkgs; [
      # Already added by hyprland
      #xdg-desktop-portal-hyprland
      
      # GTK
      xdg-desktop-portal-gtk
    ];
  };
}
