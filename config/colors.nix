{config, ...}: let
  clr = base: "${config.lib.stylix.colors.${"base" + base}}";
  rgba = base: opacity: "rgba(${config.lib.stylix.colors.${"base" + base + "-rgb-r"}}, ${config.lib.stylix.colors.${"base" + base + "-rgb-g"}}, ${config.lib.stylix.colors.${"base" + base + "-rgb-b"}}, ${toString opacity})";
  colors = {
    #accent = "0D";
    #accent-alt = "03";
    accent = "07";
    accent-alt = "06";

    background = "00";
    background-alt = "01";

    foreground = "07";
    foreground-alt = "06";

    border-color = "02";
    border-color-inactive = "02";
  };
in {
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
