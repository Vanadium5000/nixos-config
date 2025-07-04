{
  lib,
  pkgs,
  ...
}:
{
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    MOZ_ENABLE_WAYLAND = "1";
    ANKI_WAYLAND = "1";

    NIXOS_OZONE_WL = "1";
    DISABLE_QT5_COMPAT = "0";
    GDK_BACKEND = "wayland";
    DIRENV_LOG_FORMAT = "";
    WLR_DRM_NO_ATOMIC = "1";

    #QT_QPA_PLATFORMTHEME = lib.mkForce "kde";

    QT_AUTO_SCREEN_SCALE_FACTOR = "1"; # enables automatic scaling
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland";

    WLR_BACKEND = "vulkan";
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";

    #SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    GSK_RENDERER = "vulkan"; # "ngl" | "vulkan"

    # Use GUI for password inputting
    SUDO_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
  };
}
