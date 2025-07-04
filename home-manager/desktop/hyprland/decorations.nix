{ config, ... }:
let
  clrs = config.var.colors-no-tags;
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
        range = 20;
        #render_power = 3;
      };

      #---------------------------------------------------------
      #                          Blur
      #---------------------------------------------------------
      blur = {
        enabled = thme.blur;
        size = 5;
        passes = 3; # more passes = more resources
        ignore_opacity = true;
        new_optimizations = true;
        noise = 0.01;
        contrast = 1; # range 0 - 2
        brightness = 1; # range 0 - 2
        # vibrancy = 0.8;
        # vibrancy_darkness = 0.9;
        popups = true;
        # popups_ignorealpha = 0.8;
        special = false;
        # xray = true;
      };
    };
  };
}
