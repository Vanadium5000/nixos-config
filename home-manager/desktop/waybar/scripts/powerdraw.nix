{ pkgs, ... }:
let
  powerdraw = pkgs.writeShellScriptBin "powerdraw" ''
    if [ -f /sys/class/power_supply/BAT*/power_now ]; then
      powerDraw="$(($(cat /sys/class/power_supply/BAT*/power_now)/1000000))w"
    fi

    if [ -z "$powerDraw" ] || [ "$powerDraw" -eq "0w" ]; then
      echo "{\"text\":\"\", \"tooltip\":\"power Draw 󱐥 $powerDraw\"}"
      exit 0
    fi

    echo "{\"text\":\"󱐥 $powerDraw\", \"tooltip\":\"power Draw 󱐥 $powerDraw\"}"
  '';
in
{
  home.packages = [
    powerdraw
  ];
}
