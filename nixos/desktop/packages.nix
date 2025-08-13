{
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    (with pkgs; [
      # GUIs
      nautilus # File Manager
      kitty # Terminal Emulator

      # CLIs
      powertop # CLI for checking battery power-draw
      wl-clipboard # System clipboard
      nvtopPackages.full # GPU monitoring

      # BTRFS
      btdu # Disk usage

      # GTK icon themes
      morewaita-icon-theme
      adwaita-icon-theme
      crystal-remix-icon-theme
    ])
    # Install gtk theme for root, some apps like gparted only run as root
    ++ (with config.home-manager.users.${config.var.username}.gtk; [
      theme.package
      iconTheme.package
    ])
    # QT libraries
    ++ (with pkgs; [
      ffmpegthumbnailer
      kdePackages.applet-window-buttons6
      kdePackages.kdegraphics-thumbnailers
      kdePackages.kimageformats
      kdePackages.kio-admin
      kdePackages.kio-extras
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qtwayland
      kdePackages.qtsvg
      resvg
    ]);

  services = {
    ratbagd.enable = true; # Used by piper
    fwupd.enable = true; # DBus service that allows applications to update firmware
  };
}
