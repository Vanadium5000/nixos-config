# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nixos-wallpapers = pkgs.callPackage ./nixos-wallpapers.nix { };
  nixy-wallpapers = pkgs.callPackage ./nixy-wallpapers.nix { };

  # It's in nixpkgs now - but hash is wrong?
  # waybar-lyric = pkgs.callPackage ./waybar-lyric.nix { };

  # Cool icon theme
  crystal-remix-icon-theme = pkgs.callPackage ./crystal-remix.nix { };
}
