# - ## Brightness
#-
#- This module provides a set of scripts to control the brightness of the screen.
#-
#- - `brightness-up` increases the brightness by 5%.
#- - `brightness-down` decreases the brightness by 5%.
#- - `brightness-set [value]` sets the brightness to the given value.
#- - `brightness-change [up|down] [value]` increases or decreases the brightness by the given value.
{pkgs, ...}: let
  increments = "5";
  smallIncrements = "1";

  # -d intel_backlight is a temporary solution, nvidia_0 is alternative and doesn't work
  brightness-change = pkgs.writeShellScriptBin "brightness-change" ''
    [[ $1 == "up" ]] && ${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight set ''${2-${increments}}%+
    [[ $1 == "down" ]] && ${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight set ''${2-${increments}}%-
  '';

  brightness-set = pkgs.writeShellScriptBin "brightness-set" ''
    ${pkgs.brightnessctl}/bin/brightnessctl set ''${1-100}%
  '';

  brightness-up = pkgs.writeShellScriptBin "brightness-up" ''
    brightness-change up ${increments}
  '';

  brightness-down = pkgs.writeShellScriptBin "brightness-down" ''
    brightness-change down ${increments}
  '';

  brightness-up-small = pkgs.writeShellScriptBin "brightness-up-small" ''
    brightness-change up ${smallIncrements}
  '';

  brightness-down-small = pkgs.writeShellScriptBin "brightness-down-small" ''
    brightness-change down ${smallIncrements}
  '';
in {
  home.packages = [
    pkgs.brightnessctl
    brightness-change
    brightness-up
    brightness-down
    brightness-up-small
    brightness-down-small
    brightness-set
  ];
}
