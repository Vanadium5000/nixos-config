{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl # Display brightness controls
    playerctl # Pause, Play, etc. player controls

    grimblast # Screenshot utility
    tesseract # Image to text cli

    #nwg-dock-hyprland # App dock
    nwg-drawer # Full-screen application launcher
  ];

  # XDG Portal
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    wlr.enable = true;
    xdgOpenUsePortal = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
