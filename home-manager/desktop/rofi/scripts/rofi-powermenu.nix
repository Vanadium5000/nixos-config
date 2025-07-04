{ pkgs, ... }:
let
  rofi-powermenu =
    pkgs.writeShellScriptBin "rofi-powermenu"
      # bash
      ''
        # Kill Rofi if already running
        if pgrep -x "rofi" >/dev/null; then
          pkill rofi
          echo "Rofi already running, exitting"
          exit 0
        fi


        options=(
          "󰌾 Lock"
          "󰍃 Logout"
          " Suspend"
          "󰑐 Reboot"
          "󰿅 Shutdown"
        )

        selected=$(printf '%s\n' "''${options[@]}" | rofi -dmenu)

        selected=''${selected:2}

        case $selected in
          "Lock")
            ${pkgs.hyprlock}/bin/hyprlock
            ;;
          "Logout")
            hyprctl dispatch exit
            ;;
          "Suspend")
            systemctl suspend
            ;;
          "Reboot")
            systemctl reboot
            ;;
          "Shutdown")
            systemctl poweroff
            ;;
        esac
      '';
in
{
  home.packages = [ rofi-powermenu ];
}
