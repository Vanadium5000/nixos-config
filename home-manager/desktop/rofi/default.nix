{
  pkgs,
  config,
  ...
}: let
  rofiPackage = pkgs.rofi-wayland.override {
    plugins = [
      pkgs.rofi-emoji-wayland
      # Overrided with wayland support
      pkgs.rofi-calc
    ];
  };
in {
  imports = [
    ./configs

    ./scripts
  ];

  home.file.".current_wallpaper" = {
    source = config.stylix.image;
    force = true;
  };

  home.packages = [
    rofiPackage
    pkgs.rofi-vpn
    pkgs.rofi-pass-wayland
  ];
}
