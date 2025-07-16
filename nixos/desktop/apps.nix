{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
    kdePackages.applet-window-buttons6
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kimageformats
    kdePackages.kio-admin
    kdePackages.qtstyleplugin-kvantum
    resvg
    sshfs
    xdg-desktop-portal

    # XDG Mime Apps
    neovim
    kdePackages.ark
    vlc
    kdePackages.okular
    kdePackages.gwenview
    floorp
  ];
}
