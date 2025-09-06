{ ... }:
{
  imports = [
    ./flatpak.nix
    ./ghostty.nix
    ./kitty.nix
    ./mime.nix
    ./spicetify.nix
    ./syncthing.nix
    ./theme.nix

    ./chromium
    #./discord
    #./firefox
    #./floorp
    ./hypr
    ./hyprland
    ./librewolf
    ./obsidian
    #./qutebrowser
    ./rofi
    ./utils
    ./vscodium
    ./waybar

    ../home.nix
    ../terminal

    ../scripts
  ];

  # Automatically create Home user directories: e.g. Pictures, Music, Documents
  xdg.userDirs.createDirectories = true;
}
