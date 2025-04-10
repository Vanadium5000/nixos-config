{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  thme = config.var.theme;
in {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;

    # Light or Dark
    polarity = "dark";

    # Enable/disable icon theming
    iconTheme = {
      enable = true;
      package = pkgs.morewaita-icon-theme.overrideAttrs {
        src = inputs.morewaita;
      };

      # Dark & light icon theme name
      dark = "MoreWaita";
      light = "MoreWaita";
    };

    # Base-16 Theme
    base16Scheme = thme.colorScheme;
    # Wallpaper, required
    image = thme.defaultWallpaper;

    # Cursor settings
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    # Opacity settings
    opacity = {
      applications = thme.opacity;
      desktop = thme.opacity;
      popups = thme.opacity;
      terminal = thme.opacity;
    };

    # Fonts
    fonts = {
      sansSerif = {
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };

      serif = {
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
    };
  };

  nixpkgs = lib.mkForce {};
}
