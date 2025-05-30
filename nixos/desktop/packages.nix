{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      # GUIs
      kitty
      keepassxc
      mpv
      libreoffice

      hyprpanel # Panel

      # CLIs
      powertop # CLI for checking battery power-draw
      wl-clipboard # System clipboard
      nvtopPackages.full # GPU monitoring

      # Gnome apps
      nautilus # File Manager
      gnome-software
      gnome-disk-utility
      gnome-clocks

      papirus-icon-theme # Icon theme

      # Obsidian
      # obsidian

      #kdePackages.breeze-icons
    ])
    # Install gtk theme for root, some apps like gparted only run as root
    ++ (with config.home-manager.users.${config.var.username}.gtk; [
      theme.package
      iconTheme.package
    ])
    # QT libraries
    ++ (with pkgs.kdePackages; [
      #applet-window-buttons6
      kdegraphics-thumbnailers
      kimageformats
      kio-admin
      qtstyleplugin-kvantum

      qtwayland
      kio-extras
      dolphin-plugins
      qtsvg
    ]);

  services = {
    ratbagd.enable = true; # Used by piper
    fwupd.enable = true; # DBus service that allows applications to update firmware
  };
}
