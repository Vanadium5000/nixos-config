{
  pkgs,
  inputs,
  ...
}: {
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome # Icons that some apps require

    roboto
    work-sans
    comic-neue
    source-sans
    comfortaa
    inter
    lato
    lexend
    jost
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    openmoji-color
    twemoji-color-font
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
  ];
}
