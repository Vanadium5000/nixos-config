{ pkgs, ... }:
let
  rofiPackage = pkgs.rofi.override {
    plugins = [
      pkgs.rofi-emoji
      # Overrided with wayland support
      pkgs.rofi-calc
    ];
  };
in
{
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
