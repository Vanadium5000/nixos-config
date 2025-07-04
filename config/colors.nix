{ config, ... }:
let
  clr = base: "${config.lib.stylix.colors.${"base" + base}}";
  rgba =
    base: opacity:
    "rgba(${config.lib.stylix.colors.${"base" + base + "-rgb-r"}}, ${
      config.lib.stylix.colors.${"base" + base + "-rgb-g"}
    }, ${config.lib.stylix.colors.${"base" + base + "-rgb-b"}}, ${toString opacity})";

  # Styling Guide: https://github.com/nix-community/stylix/blob/master/doc/src/styling.md#general-colors

  # General colors:
  # Default background: base00
  # Alternate background: base01
  # Selection background: base02
  # Default text: base05
  # Alternate text: base04
  # Warning: base0A
  # Urgent: base09
  # Error: base08

  # Window Managers:
  # Unfocused window border: base03
  # Focused window border: base0D
  # Unfocused window border in group: base03
  # Focused window border in group: base0D
  # Urgent window border: base08
  # Window title text: base05

  # Notifications & Popups:
  # Window border: base0D
  # Low urgency background color: base06
  # Low urgency text color: base0A
  # High urgency background color: base0F
  # High urgency text color: base08
  # Incomplete part of progress bar: base01
  # Complete part of progress bar: base02

  colors = {
    #accent = "0D";
    #accent-alt = "03";
    accent = "0D";
    accent-alt = "0C";

    background = "00";
    background-alt = "01";

    foreground = "05";
    foreground-alt = "06";

    border-color = "0D";
    border-color-inactive = "03";
  };
in
{
  config.var = {
    # Gets hexadecimal colors

    # Adds '#' to start of each value
    colors = builtins.mapAttrs (_: value: "#" + clr value) colors;
    # Does not add '#'
    colors-no-tags = builtins.mapAttrs (_: clr) colors;

    # rgba(r, g, b, a)
    colors-rgba = opacity: builtins.mapAttrs (_: value: (rgba value opacity)) colors;

    # base00, base01, etc...
    stylix = config.lib.stylix.colors;
  };
}
