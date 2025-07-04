# - ## Waybar
#-
#- Quick scripts to toggle, reload and kill waybar.
#-
#- - `waybar-toggle` - Toggle waybar.
#- - `waybar-reload` - Reload waybar.
#- - `waybar-kill` - Kill waybar.
{ pkgs, ... }:
let
  waybar-toggle = pkgs.writers.writeBashBin "waybar-toggle" ''
    if [ -n "$(pgrep waybar || true)" ]; then
      pkill waybar
    else
      hyprctl dispatch exec "waybar"
    fi
  '';

  waybar-show = pkgs.writers.writeBashBin "waybar-show" ''
    if [ -n "$(pgrep waybar || true)" ]; then
      echo "waybar is already running"
    else
      hyprctl dispatch exec "waybar"
    fi
  '';

  waybar-reload = pkgs.writers.writeBashBin "waybar-reload" ''
    [ -n "$(pgrep "waybar")" ] && pkill waybar
    hyprctl dispatch exec waybar
  '';
in
{
  home.packages = [
    waybar-toggle
    waybar-reload
    waybar-show
  ];
}
