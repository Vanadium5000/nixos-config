{ pkgs, ... }:
{
  # Shell aliases
  home.shellAliases = {
    # Clears screen + scrollback
    "c" = "printf '\\033[2J\\033[3J\\033[1;1H'";

    # General aliases
    "edit" = "sudo -e";
    ":q" = "exit";

    # Eza, ls alternative
    "ls" = "eza";
    "tree" = "eza --tree";

    # Tools
    "open" = "${pkgs.xdg-utils}/bin/xdg-open";
    "icat" = "${pkgs.kitty}/bin/kitty +kitten icat";

    # System actions
    suspend = "systemctl suspend";
    reboot = "systemctl reboot";
    logout = "hyprctl dispatch exit";
    poweroff = "systemctl poweroff";
  };
}
