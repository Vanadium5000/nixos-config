{ pkgs, ... }:
{
  # Protect your eyes from eye strain with reminders to rest, etc.
  home.packages = with pkgs; [ safeeyes ];

  # Service to start safeeyes
  systemd.user.services.safeeyes = {
    Unit = {
      Description = "Autostart safeeyes";
      After = [ "waybar.service" ]; # Ensures safeeyes starts after waybar
      BindsTo = [ "waybar.service" ]; # Binds the service lifecycle to waybar (restarts when waybar restarts)
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      # Start command
      ExecStart = pkgs.writeShellScript "safeeyes-start" ''
        ${pkgs.safeeyes}/bin/safeeyes
      '';
      Restart = "on-failure"; # Optional: restart on failure
    };
  };
}
