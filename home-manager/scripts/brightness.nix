# - ## Brightness
#-
#- This module provides a set of scripts to control the brightness of the screen.
#-
#- - `brightness-up` increases the brightness by 5%.
#- - `brightness-down` decreases the brightness by 5%.
#- - `brightness-set [value]` sets the brightness to the given value.
#- - `brightness-change [up|down] [value]` increases or decreases the brightness by the given value.
{ pkgs, ... }:
let
  increments = "5";
  smallIncrements = "1";

  # $2 is an optional argument which can include the device to change
  brightness-change = pkgs.writeShellScriptBin "brightness-change" ''
    if [[ -n $3 ]]; then
      [[ $1 == "up" ]] && ${pkgs.brightnessctl}/bin/brightnessctl -d "$3" set ''${2-${increments}}%+
      [[ $1 == "down" ]] && ${pkgs.brightnessctl}/bin/brightnessctl -d "$3" set ''${2-${increments}}%-
    else
      [[ $1 == "up" ]] && ${pkgs.brightnessctl}/bin/brightnessctl set ''${2-${increments}}%+
      [[ $1 == "down" ]] && ${pkgs.brightnessctl}/bin/brightnessctl set ''${2-${increments}}%-
    fi
  '';

  brightness-set = pkgs.writeShellScriptBin "brightness-set" ''
    ${pkgs.brightnessctl}/bin/brightnessctl set ''${1-100}%
  '';

  brightness-up = pkgs.writeShellScriptBin "brightness-up" ''
    brightness-change up ${increments} $1
  '';

  brightness-down = pkgs.writeShellScriptBin "brightness-down" ''
    brightness-change down ${increments} $1
  '';

  brightness-up-small = pkgs.writeShellScriptBin "brightness-up-small" ''
    brightness-change up ${smallIncrements} $1
  '';

  brightness-down-small = pkgs.writeShellScriptBin "brightness-down-small" ''
    brightness-change down ${smallIncrements} $1
  '';
in
{
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
