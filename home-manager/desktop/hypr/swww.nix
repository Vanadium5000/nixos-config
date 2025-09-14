# Swww is used to set the wallpaper on the system
{ lib, ... }:
{
  services.swww.enable = true;

  stylix.targets.hyprpaper.enable = lib.mkForce false;

  # Persist wallpaper & wallpaper cache
  customPersist.home.files = [
    ".current_wallpaper"
    ".cache/swww/eDP-1"
  ];
}
