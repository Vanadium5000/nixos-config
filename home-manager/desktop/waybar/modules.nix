_: {
  # https://github.com/gzowski/public_configs/blob/main/.config/waybar/config
  # Options: https://github.com/Alexays/Waybar/wiki/Configuration
  programs.waybar.settings = {
    mainBar = {
      "custom/os_button" = {
        "format" = "";
        "on-click" = "rofi-menu";
        "tooltip" = false;
      };
      # "hyprland/workspaces" = {
      #   format = "{icon}";
      #
      #   format-icons = {
      #     active = "";
      #     default = "";
      #     empty = "";
      #   };
      # };
      # "hyprland/window" = {
      #   max-length = 60;
      #   format = "{}";
      #   icon = true;
      #   rewrite = {
      #     "" = " Empty Workspace";
      #   };
      #   separate-outputs = true;
      # };
      mpris = {
        format = "{player_icon} {dynamic}";
        format-paused = "{status_icon} <i>{dynamic}</i>";
        player-icons = {
          default = "▶";
          mpv = "🎵";
        };
        status-icons = {
          paused = "⏸";
        };
      };
      disk = {
        interval = 30;
        format = " {percentage_used}%";
        path = "/";
      };
      battery = {
        bat = "BAT2";
        interval = 60;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        max-length = 25;
      };
      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };
      tray = {
        spacing = 10;
        show-passive-items = true;
      };
      clock = {
        timezone = "Europe/London";
        format = "󰸗 {:%a %d %b %H:%M:%S}";
        tooltip-format = "\n<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";

        calendar-weeks-pos = "right";
        today-format = "<span color='#7645AD'><b><u>{}</u></b></span>";
        format-calendar = "<span color='#aeaeae'><b>{}</b></span>";
        format-calendar-weeks = "<span color='#aeaeae'><b>W{:%V}</b></span>";
        format-calendar-weekdays = "<span color='#aeaeae'><b>{}</b></span>";

        interval = 1;
        on-click = "zenity --calendar";
      };
      cpu = {
        interval = 5;
        format = " {}%";
        format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      };
      memory = {
        format = " {used:0.1f}G/{total:0.1f}G";
      };
      "pulseaudio/slider" = {
        min = 0;
        max = 100;
        orientation = "horizontal";
      };
      pulseaudio = {
        scroll-step = 5;
        format = "{icon} {volume}%";
        format-muted = " Muted";
        format-icons = {
          default = [
            ""
            ""
            ""
          ];
        };
        on-click = "pavucontrol";
        on-click-middle = "pamixer -t";
      };
    };
  };
}
