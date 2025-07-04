{ pkgs, ... }:
{
  services = {
    # A simple GTK based notification daemon
    swaync.enable = true;

    # A GTK based on screen display for keyboard shortcuts like caps-lock and volume
    swayosd.enable = true;
  };

  # Enable swayosd on volume/brightness/etc. change
  wayland.windowManager.hyprland.settings = {
    bind = [
      ", XF86AudioMute, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume mute-toggle"
      "SHIFT, XF86AudioMute, exec, ${pkgs.swayosd}/bin/swayosd-client --input-volume mute-toggle"
      ", XF86AudioMicMute, exec, ${pkgs.swayosd}/bin/swayosd-client --input-volume mute-toggle"
      ", Caps_Lock, exec, ${pkgs.swayosd}/bin/swayosd-client --caps-lock"
    ];
    binde = [
      ", XF86AudioRaiseVolume, execr, ${pkgs.swayosd}/bin/swayosd-client --output-volume raise"
      ", XF86AudioLowerVolume, execr, ${pkgs.swayosd}/bin/swayosd-client --output-volume lower"
      "SHIFT, XF86AudioRaiseVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --input-volume raise"
      "SHIFT, XF86AudioLowerVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --input-volume lower"
      ", XF86MonBrightnessUp, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness raise"
      ", XF86MonBrightnessDown, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness lower"
    ];
    # NOTE swayosd is also used in waybar pulseaudio plugin!
  };
}
