{
  pkgs,
  config,
  lib,
  ...
}:
{
  home = {
    # Cursor
    pointerCursor = {
      #gtk.enable = true;
      #hyprcursor.enable = true;
      # x11.enable = true;
    };

    # Packages
    packages = with pkgs; [
      morewaita-icon-theme
      adwaita-icon-theme
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

  home.file = {
    # Enable gtk theme for flatpaks
    ".local/share/flatpak/overrides/global".text =
      let
        dirs = [
          "/nix/store:ro"
          "xdg-config/gtk-3.0:ro"
          "xdg-config/gtk-4.0:ro"
          "${config.xdg.dataHome}/icons:ro"
        ];
      in
      ''
        [Context]
        filesystems=${builtins.concatStringsSep ";" dirs}
      '';
  };
  stylix.targets.gtk.flatpakSupport.enable = false; # Use solution above instead
}
