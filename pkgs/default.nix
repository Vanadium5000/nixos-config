# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nixos-wallpapers = pkgs.callPackage ./nixos-wallpapers.nix { };
  nixy-wallpapers = pkgs.callPackage ./nixy-wallpapers.nix { };

  # TODO: Remove this due to it being in nixpkgs one I update
  waybar-lyric = pkgs.callPackage ./waybar-lyric.nix { };
}
