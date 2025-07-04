# - ## Screenshot
#-
#- This module provides a script to take screenshots using `grimblast` and `tesseract`.
#-
#- - `screenshot [active|area|monitor] [toText]` - Take a screenshot of the region, window, or monitor. Optionally, use `tesseract` to convert the screenshot to text and copy to the clipboard.
{ pkgs, ... }:
let
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    folder="$HOME/Pictures/Screenshots"
    filename="Screenshot $(date +%Y-%m-%d_%H:%M:%S).png"

    if [[ $1 == "active" ]];then
      mode="active"
    elif [[ $1 == "area" ]];then
      mode="area"
    elif [[ $1 == "monitor" ]];then
      mode="output"
    fi

    if [[ $2 == "toText" ]];then
      ${pkgs.grimblast}/bin/grimblast --notify save $mode - | ${pkgs.tesseract}/bin/tesseract - - | ${pkgs.wl-clipboard}/bin/wl-copy || exit 1
    else
      ${pkgs.grimblast}/bin/grimblast --notify copysave $mode "$folder/$filename" || exit 1
    fi
  '';
in
{
  home.packages = [
    screenshot
    pkgs.grimblast
    pkgs.swappy
    pkgs.wl-clipboard
  ];
}
