{ pkgs, ... }:
{
  # Protect your eyes from eye strain with reminders to rest, etc.
  home.packages = with pkgs; [ safeeyes ];
  # wayland.windowManager.hyprland.settings.exec-once = [
  #   "safeeyes"
  # ];

  systemd.user.services.safeeyes = {
    Unit = {
      Description = "Autostart safeeyes";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = pkgs.writeShellScript "safeeyes-start" ''
        ${pkgs.safeeyes}/bin/safeeyes
      '';
    };
  };
}
