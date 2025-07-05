{ ... }:
{
  imports = [
    ./dolphin.nix
    ./flatpak.nix
    ./ghostty.nix
    ./kitty.nix
    ./theme.nix
    ./mime.nix
    ./spicetify.nix

    ./chromium
    ./discord
    #./end_4
    ./firefox
    ./floorp
    ./hypr
    ./hyprland
    ./obsidian
    #./quickshell
    #./qutebrowser
    ./rofi
    ./utils
    ./vscodium
    ./waybar

    ../home.nix
    ../terminal

    ../scripts
  ];
}
