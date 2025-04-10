_: {
  # Each toolkit has its own mechanism for setting x11 scaling
  home.sessionVariables = {
    GDK_SCALE = 2; # Won’t conflict with Wayland-native GTK programs
  };

  wayland.windowManager.hyprland.settings.xwayland = {
    force_zero_scaling = true; # This will get rid of the pixelated look, but will not scale applications properly
  };
}
