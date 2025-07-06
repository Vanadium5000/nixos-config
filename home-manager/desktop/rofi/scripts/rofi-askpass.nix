{ pkgs, ... }:
let
  rofi-askpass = pkgs.writeShellScriptBin "rofi-askpass" ''
    : | rofi -dmenu \
      -sync \
      -password \
      -i \
      -no-fixed-num-lines \
      -p "Password: " \
      2> /dev/null
  '';
in
{
  # Use GUI for password inputting
  home.sessionVariables.SUDO_ASKPASS = "rofi-askpass";
  # Note: a sudo wrapper in nixos/desktop/default.nix
  #  adds the -A flag to the sudo package which makes it follow the SUDO_ASKPASS variable

  home.packages = [
    rofi-askpass
  ];
}
