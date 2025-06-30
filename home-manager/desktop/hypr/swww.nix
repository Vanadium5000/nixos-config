# Swww is used to set the wallpaper on the system
{lib, ...}: {
  wayland.windowManager.hyprland.settings.exec-once = ["swww" "img" "~/.current_wallpaper"];
  services.swww.enable = true;

  stylix.targets.hyprpaper.enable = lib.mkForce false;

  # Persist wallpaper
  customPersist.home.files = [".current_wallpaper"];
}
# swww img /nix/store/m2vc15xiaqgyy090xfyqzh8px81436iw-nixos-wallpapers-unstable-2024-12-10/wallpapers/NixOS-Gradient-grey.png

