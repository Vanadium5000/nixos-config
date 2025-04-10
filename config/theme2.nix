{
  pkgs,
  config,
  ...
}: {
  config.var.theme2 = {
    rounding = 10;
    button-rounding = 8;

    gaps-in = 5;
    gaps-out = 8;
    active-opacity = 1.0;
    inactive-opacity = 0.75;
    blur = true;
    shadows = false;
    border-size = 2;
    animation-speed = "slow"; # "fast" | "medium" | "slow"
    fetch = "nerdfetch"; # "nerdfetch" | "neofetch" | "pfetch" | "none"

    # https://tinted-theming.github.io/base16-gallery/
    colorScheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml"; #ayu-mirage

    bar = {
      position = "top"; # "top" | "bottom"
      transparent = false; # Make bar transparent
      transparentButtons = true; # Make button backgrounds transparent

      floating = true;
      borders = false;
      bar-border = false;
      opacity = 0.7;

      style = "default"; # "split" | "default"

      spacing = {
        button-padding-x = "0.7rem";
        button-padding-y = "0.2rem";
        button-gap = "0.25em"; # Gap between buttons
      };

      font = config.stylix.fonts.sansSerif.name;
    };

    launcher = {
      opacity = 0.7;
    };

    lockscreen = {
      opacity = 0.75;
      dark = false;
    };
  };
}
