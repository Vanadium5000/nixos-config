# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nixos-wallpapers = pkgs.callPackage ./nixos-wallpapers.nix {};
  nixy-wallpapers = pkgs.callPackage ./nixy-wallpapers.nix {};

  # Tmux plugins
  catppuccin = pkgs.callPackage ./catppuccin.nix {};
  battery = pkgs.callPackage ./battery.nix {};
  cpu = pkgs.callPackage ./cpu.nix {};

  # End_4
  #illogical-impulse-oneui4-icons = pkgs.callPackage ./illogical-impulse-oneui4-icons.nix;

  # Caelestia
  caelestia-cli = pkgs.callPackage ./caelestia-cli.nix {};
}
