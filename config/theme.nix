{
  pkgs,
  config,
  ...
}: {
  config.var.theme = {
    rounding = 10;
    button-rounding = 0;

    gaps-in = 2; # between windows/buttons
    gaps-out = 3; # between windows and border of display

    # Hyprland windows
    active-opacity = 1.0;
    inactive-opacity = 0.75;

    # Default opacity
    opacity = 0.7;

    blur = true;
    shadows = false;
    use-opacity = true;

    border-size = 2;

    animation-speed = "slow"; # "fast" | "medium" | "slow"

    # https://tinted-theming.github.io/base16-gallery/
    colorScheme = "${pkgs.base16-schemes}/share/themes/framer.yaml"; #ayu-mirage
    defaultWallpaper = "${pkgs.nixy-wallpapers}/wallpapers/fuji-dark.png";

    bar = {
      position = "top"; # "top" | "bottom"
      transparent = true; # Make button backgrounds transparent

      borders = false; # Whether to enable borders

      opacity = 0.7;

      font = config.stylix.fonts.monospace.name;
    };

    launcher = {
      opacity = 0.7;
    };

    lockscreen = {
      opacity = 0.7;
      dark = false; # swaps background & foreground
    };
  };
}
