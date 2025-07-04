# Hyprlock is a lockscreen for Hyprland
{ config, ... }:
let
  inherit (config.var.theme.lockscreen) dark;
  clrs = config.var.colors-rgba thme.lockscreen.opacity;
  thme = config.var.theme;

  imageStr = "~/.current_wallpaper";
  font = config.stylix.fonts.serif.name;
  fontSize = config.stylix.fonts.sizes.desktop;

  scale = x: (builtins.floor (x * 1.5));
in
{
  stylix.targets.hyprlock.enable = false;

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0; # Time before actually locking/not just disappearing when cursor moves
        immediate_render = true; # Makes hyprlock immediately start to draw widgets
      };

      animations = {
        enabled = true;
      };

      # BACKGROUND
      background = {
        monitor = "";
        path = imageStr;
      };

      label = [
        {
          # Day-Month-Date
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = if dark then clrs.background else clrs.foreground;
          font_size = scale 20;
          font_family = font + " Bold";
          position = "0, ${toString (scale 405)}";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = if dark then clrs.background else clrs.foreground;
          font_size = scale 93;
          font_family = font + " Bold";
          position = "0, ${toString (scale 310)}";
          halign = "center";
          valign = "center";
        }
        # USER
        {
          monitor = "";
          text = "$USER";
          color = if dark then clrs.background else clrs.foreground;
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          font_size = scale fontSize;
          font_family = font + " Bold";
          position = "0, ${toString (scale (-407))}";
          halign = "center";
          valign = "center";
        }
        # Other label
        {
          monitor = "";
          text = "Touch ID or Enter Password";
          color = if dark then clrs.background-alt else clrs.foreground-alt;
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          font_size = scale (fontSize - 3);
          font_family = font;
          position = "0, ${toString (scale (-438))}";
          halign = "center";
          valign = "center";
        }
      ];

      # INPUT FIELD
      input-field = [
        {
          monitor = "";
          size = "${toString (scale 300)}, ${toString (scale 30)}";
          outline_thickness = 0;
          dots_size = 0.25; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.55; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          dots_rounding = -1;
          #outer_color =
          #  if dark
          #  then clrs.background
          #  else clrs.foreground;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(255, 255, 255, 0)";
          font_color = if dark then clrs.background else clrs.foreground;

          check_color = "rgba(204, 136, 34, 0)";
          fail_color = "rgba(204, 34, 34, 0)"; # if authentication failed, changes outer_color and fail message color
          hide_input_base_color = "rgba(0, 0, 0, 0)"; # color for hide_input, shouldn't happen

          fade_on_empty = false;
          font_family = font;
          placeholder_text = "";
          fail_text = "$FAIL <b>($ATTEMPTS)</b>";
          fail_transition = 300; # transition time in ms between normal outer_color and fail_color
          hide_input = false;
          position = "0, ${toString (scale (-468))}";
          halign = "center";
          valign = "center";

          invert_numlock = false; # change color if numlock is off
          swap_font_color = false; # see below
        }
      ];

      # Image
      image = [
        # Profile picture
        {
          monitor = "";
          path = "${../../../src/NixOS_purple_unstable.png}";
          border_color = "0xffdddddd";
          border_size = "0";
          size = scale 73;
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          reload_cmd = "";
          position = "0, ${toString (scale (-353))}";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
