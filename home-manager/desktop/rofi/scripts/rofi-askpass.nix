{ lib, pkgs, ... }:
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
  home.sessionVariables.SUDO_ASKPASS = lib.getExe rofi-askpass;

  # Shell alias
  home.shellAliases = {
    # Use SUDO_ASKPASS variable
    sudo = "sudo -A";
  };

  home.packages = [
    rofi-askpass

    # More reliable way to make everything use rofi-askpass
    (pkgs.writeShellScriptBin "sudo" "sudo -A $@")
  ];
}
