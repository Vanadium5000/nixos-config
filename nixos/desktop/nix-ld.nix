{ pkgs, ... }:
{
  # Run unpatched dynamic binaries on NixOS
  # Fixes "missioncenter" flatpak
  # https://github.com/NixOS/nixpkgs/issues/349957
  programs.nix-ld = {
    enable = true;
    # https://github.com/garuda-linux/garuda-nix-subsystem/blob/ebc62330d4fca661356f1383d24dbf7ba4378475/internal/modules/base/programs.nix#L50
    libraries = with pkgs; [
      SDL2
      curl
      freetype
      gdk-pixbuf
      glib
      glibc
      icu
      libglvnd
      libnotify
      libsecret
      libunwind
      libuuid
      openssl
      stdenv.cc.cc
      util-linux
      vulkan-loader
      xorg.libX11
      zlib
    ];
  };
}
