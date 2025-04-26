{
  pkgs,
  config,
  lib,
  ...
}: {
  home = {
    # Cursor
    pointerCursor = {
      #gtk.enable = true;
      #hyprcursor.enable = true;
      # x11.enable = true;
    };

    # Packages
    packages = with pkgs; [
      font-awesome
      adwaita-icon-theme
      #morewaita-icon-theme
      qogir-icon-theme
      papirus-icon-theme
      libssh # sftp
      kdePackages.dolphin
      ffmpegthumbnailer
    ];
  };

  # Gtk
  gtk = {
    enable = true;

    # Also set by Stylix
    iconTheme = {
      package = lib.mkForce pkgs.morewaita-icon-theme;

      name = lib.mkForce "MoreWaita";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    # Use kvantum for qt themes
    style.name = "kvantum";
  };

  home.file = {
    # Install ArcDark kvantum theme
    ".config/Kvantum/ArcDark".source = "${pkgs.arc-kde-theme}/share/Kvantum/ArcDark";
    #".config/Kvantum/kvantum.kvconfig".text = lib.generators.toINI {} {General.theme = "ArcDark";};

    # Use papirus icon theme
    # ".config/qt5ct/qt5ct.conf".text = lib.generators.toINI {} {
    #   Appearance = {
    #     style = "kvantum";
    #     standard_dialogs = "xdgdesktopportal";
    #     icon_theme = config.gtk.iconTheme.name;
    #   };
    # };
    # ".config/qt6ct/qt6ct.conf".text = lib.generators.toINI {} {
    #   Appearance = {
    #     style = "kvantum";
    #     standard_dialogs = "xdgdesktopportal";
    #     icon_theme = config.gtk.iconTheme.name;
    #   };
    # };

    # Enable gtk theme for flatpaks
    ".local/share/flatpak/overrides/global".text = let
      dirs = [
        "/nix/store:ro"
        "xdg-config/gtk-3.0:ro"
        "xdg-config/gtk-4.0:ro"
        "${config.xdg.dataHome}/icons:ro"
      ];
    in ''
      [Context]
      filesystems=${builtins.concatStringsSep ";" dirs}
    '';
  };
  stylix.targets.gtk.flatpakSupport.enable = false; # Use solution above instead
}
