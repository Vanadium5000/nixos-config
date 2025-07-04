{ pkgs, ... }:
{
  systemd.user.services.polkit-kde-autostart = {
    Unit = {
      Description = "Autostart kde-polkit-agent";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = pkgs.writeShellScript "kde-polkit-agent-start" ''
        ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1
      '';
    };
  };
}
