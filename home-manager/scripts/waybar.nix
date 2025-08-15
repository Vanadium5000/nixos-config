# - ## Waybar
#-
#- Quick scripts to toggle, reload and kill waybar.
#-
#- - `waybar-toggle` - Toggle waybar.
#- - `waybar-reload` - Reload waybar.
#- - `waybar-kill` - Kill waybar.
{ pkgs, ... }:
let
  waybar-toggle = pkgs.writeShellScriptBin "waybar-toggle" ''
    # Check if waybar service is active
    if systemctl --user is-active --quiet waybar.service; then
        # If active, stop the service
        systemctl --user stop waybar.service
        echo "waybar has been stopped."
    else
        # If inactive, start the service
        systemctl --user start waybar.service
        echo "waybar has been started."
    fi
  '';

  waybar-show = pkgs.writers.writeBashBin "waybar-show" ''
    # Check if waybar service is active
    if systemctl --user is-active --quiet waybar.service; then
        # If active, do nothing
        echo "waybar is already running."
    else
        # If inactive, start the service
        systemctl --user start waybar.service
        echo "waybar has been started."
    fi
  '';

  waybar-reload = pkgs.writers.writeBashBin "waybar-reload" ''
    # Restart waybar service
    systemctl --user restart waybar.service
  '';
in
{
  home.packages = [
    waybar-toggle
    waybar-reload
    waybar-show
  ];
}
