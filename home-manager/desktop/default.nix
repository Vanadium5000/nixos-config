{...}: {
  imports = [
    ./ags.nix
    ./flatpak.nix
    ./ghostty.nix
    ./kitty.nix
    ./theme.nix
    ./mime.nix
    #./quickshell.nix
    ./spicetify.nix
    ./stylix.nix

    ./discord
    ./floorp
    ./hypr
    ./hyprland
    ./qutebrowser
    ./rofi
    ./utils
    ./vscodium
    ./waybar

    ../home.nix
    ../terminal

    ../scripts
  ];
}
