{ pkgs, ... }:
let
  rofi-screenshot =
    pkgs.writeShellScriptBin "rofi-screenshot"
      # bash
      ''
        # Kill Rofi if already running
        if pgrep -x "rofi" >/dev/null; then
          pkill rofi
          echo "Rofi already running, exitting"
          exit 0
        fi


        options=(
          "󰼢 Screenshot area"
          "󱇤 Screenshot area & edit"
          "󱓦 Edit image in clipboard"
          "󱘣 Copy text from area"
          "󰹑 Screenshot monitor"
        )

        selected=$(printf '%s\n' "''${options[@]}" | rofi -dmenu)

        selected=''${selected:2}

        case $selected in
          "Screenshot area")
            screenshot area
            ;;
          "Screenshot area & edit")
            screenshot area
            wl-paste | swappy -f -
            ;;
          "Edit image in clipboard")
            wl-paste | swappy -f -
            ;;
          "Copy text from area")
            screenshot area toText
            ;;
          "Screenshot monitor")
            screenshot monitor
            ;;
        esac
      '';
in
{
  home.packages = [ rofi-screenshot ];
}
