{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    (with kdePackages; [
      kio
      kio-extras
      qtsvg # for icons
      ffmpegthumbs # for previews
      dolphin
      konsole
      kservice # for applications list
      shared-mime-info
    ]);
}
