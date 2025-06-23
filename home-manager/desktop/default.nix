{...}: {
  imports = [
    ./flatpak.nix
    ./ghostty.nix
    ./kitty.nix
    ./theme.nix
    ./mime.nix
    ./spicetify.nix
    ./stylix.nix

    ./discord
    #./end_4
    ./floorp
    ./hypr
    ./hyprland
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
