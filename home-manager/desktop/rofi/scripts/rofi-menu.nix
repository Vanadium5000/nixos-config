{ pkgs, ... }:
let
  rofi-menu =
    pkgs.writeShellScriptBin "rofi-menu"
      # bash
      ''
        # Kill Rofi if already running
        if pgrep -x "rofi" >/dev/null; then
          pkill rofi
          echo "Rofi already running, exitting"
          exit 0
        fi

        rofi -show drun
      '';
in
{
  home.packages = [ rofi-menu ];
}
