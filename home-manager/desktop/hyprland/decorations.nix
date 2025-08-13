{ config, lib, ... }:
let
  #clrs = config.var.colors-no-tags;
  thme = config.var.theme;
in
{
  wayland.windowManager.hyprland = {
    #-------------------------------------------------------------
    #                       Decoration section
    #-------------------------------------------------------------
    # Inspired by https://github.com/cybergaz/hyprland_rice/blob/master/.config/hypr/hyprland.conf
    settings.decoration = {
      inherit (thme) rounding;

      #---------------------------------------------------------
      #                         Opacity
      #---------------------------------------------------------
      active_opacity = thme.active-opacity;
      inactive_opacity = thme.inactive-opacity;
      dim_inactive = 0;
      dim_strength = 0.5;
      dim_around = 0.5;
      dim_special = 0.5;

      #---------------------------------------------------------
      #                         Shadows
      #---------------------------------------------------------
      shadow = {
        enabled = thme.shadows;
        range = 16;
        render_power = 5;
        color = lib.mkForce "rgba(0,0,0,0.35)";
      };

      #---------------------------------------------------------
      #                          Blur
      #---------------------------------------------------------
      blur = {
        enabled = thme.blur;
        size = 2;
        passes = 3; # more passes = more resources
        new_optimizations = true;
        vibrancy = 0.1696;
      };
    };
  };
}
