# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nixos-wallpapers = pkgs.callPackage ./nixos-wallpapers.nix {};
  nixy-wallpapers = pkgs.callPackage ./nixy-wallpapers.nix {};

  # Tmux plugins
  catppuccin = pkgs.callPackage ./catppuccin.nix {};
  battery = pkgs.callPackage ./battery.nix {};
  cpu = pkgs.callPackage ./cpu.nix {};
}
