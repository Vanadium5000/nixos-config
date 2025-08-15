{
  pkgs,
  config,
  ...
}:
{
  config.var.theme = {
    rounding = 8;
    button-rounding = 8;

    gaps-in = 2; # between windows/buttons
    gaps-out = 3; # between windows and border of display

    # Hyprland windows
    active-opacity = 1.0;
    inactive-opacity = 1.0; # No change - 0.75 for change

    # Default opacity
    opacity = 0.3; # 0.7

    blur = true;
    shadows = true;
    use-opacity = true;

    border-size = 1;

    animation-speed = "slow"; # "fast" | "medium" | "slow"

    # https://tinted-theming.github.io/base16-gallery/
    # colorScheme = "${pkgs.base16-schemes}/share/themes/3024-night.yaml"; # ayu-mirage

    # You would think how many themes there are, there would be one which has a dark background that isn't just an off-black
    colorScheme = ./windows-95.yaml;
    defaultWallpaper = "${pkgs.nixy-wallpapers}/wallpapers/fuji-dark.png";

    bar = {
      position = "top"; # "top" | "bottom"
      transparent = true; # Make button backgrounds transparent

      borders = true; # Whether to enable borders

      opacity = 0.3;

      font = config.stylix.fonts.monospace.name;
    };

    launcher = {
      opacity = 0.3;
    };

    lockscreen = {
      opacity = 0.7;
      dark = false; # swaps background & foreground
    };
  };
}
