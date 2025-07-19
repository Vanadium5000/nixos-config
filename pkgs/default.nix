# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nixos-wallpapers = pkgs.callPackage ./nixos-wallpapers.nix { };
  nixy-wallpapers = pkgs.callPackage ./nixy-wallpapers.nix { };

  # It's in nixpkgs anyways but use the latest from the main branch instead of latest version
  waybar-lyric = pkgs.callPackage ./waybar-lyric.nix { };
}
