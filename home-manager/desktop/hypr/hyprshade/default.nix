{ pkgs, ... }:
{
  home.file.".config/hypr/hyprshade.toml" = {
    text = ''
      [[shades]]
      name = "vibrance"
      default = true

      [[shades]]
      name = "blue-light-filter"
      start_time = 19:00:00
      end_time = 22:15:00

      [[shades]]
      name = "grayscale"
      start_time = 22:15:00
      end_time = 06:30:00
    '';
  };
  home.file.".config/hypr/shaders/grayscale.glsl".source = ./grayscale.glsl;
  home.file.".config/hypr/shaders/blue-light-filter.glsl.mustache".source =
    ./blue-light-filter.glsl.mustache;

  systemd.user.services.hyprshade = {
    Unit = {
      Description = "Apply screen filter";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.hyprshade}/bin/hyprshade auto";
    };
  };

  systemd.user.timers.hyprshade = {
    Unit = {
      Description = "Run hyprshade auto every 10 minutes";
    };
    Timer = {
      OnBootSec = "1min"; # Specifies the delay after the system boots
      OnUnitActiveSec = "10min"; # Normal interval
      Unit = "hyprshade.service"; # Explicitly link to the service

      OnCalendar = [
        "*-*-* 19:00:00"
        "*-*-* 22:15:00"
        "*-*-* 06:30:00"
      ];
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec = [
      "${pkgs.hyprshade}/bin/hyprshade auto"
    ];
  };
}
