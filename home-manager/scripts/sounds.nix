# - ## Sound
#-
#- This module provides a set of scripts to control the volume of the default audio sink using `wpctl`.
#-
#- - `sound-up` increases the volume by 5%.
#- - `sound-down` decreases the volume by 5%.
#- - `sound-set [value]` sets the volume to the given value.
#- - `sound-toggle` toggles the mute state of the default audio sink.
{ pkgs, ... }:

let
  increments = "5";
  smallIncrements = "1";

  sound-change = pkgs.writeShellScriptBin "sound-change" ''
    [[ $1 == "mute" ]] && wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    [[ $1 == "up" ]] && wpctl set-volume @DEFAULT_AUDIO_SINK@ ''${2-${increments}}%+
    [[ $1 == "down" ]] && wpctl set-volume @DEFAULT_AUDIO_SINK@ ''${2-${increments}}%-
    [[ $1 == "set" ]] && wpctl set-volume @DEFAULT_AUDIO_SINK@ ''${2-100}%
  '';

  sound-up = pkgs.writeShellScriptBin "sound-up" ''
    sound-change up ${increments}
  '';
  sound-up-small = pkgs.writeShellScriptBin "sound-up-small" ''
    sound-change up ${smallIncrements}
  '';

  sound-set = pkgs.writeShellScriptBin "sound-set" ''
    sound-change set ''${1-100}
  '';

  sound-down = pkgs.writeShellScriptBin "sound-down" ''
    sound-change down ${increments}
  '';
  sound-down-small = pkgs.writeShellScriptBin "sound-down-small" ''
    sound-change down ${smallIncrements}
  '';

  sound-toggle = pkgs.writeShellScriptBin "sound-toggle" ''
    sound-change mute
  '';
in
{
  home.packages = [
    sound-change

    sound-up
    sound-down
    sound-up-small
    sound-down-small

    sound-toggle
    sound-set
  ];
}
