{pkgs, ...}: let
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

  home.packages = [
    rofiPackage
    pkgs.rofi-vpn
    pkgs.rofi-pass-wayland
  ];
}
