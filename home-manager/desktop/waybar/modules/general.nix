_: {
  # https://github.com/ashish-kus/waybar-minimal/blob/main/src/config.jsonc
  # Options: https://github.com/Alexays/Waybar/wiki/Configuration
  programs.waybar.settings = {
    mainBar = {
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󰾪";
          deactivated = "󰅶";
        };
      };
      tray = {
        icon-size = 14;
        spacing = 10;

        show-passive-items = true;
      };
      clock = {
        format = "󰸗 {:%a %d %b  %H:%M:%S}";
        interval = 1;
        on-click = "gnome-calendar";

        calendar = {
          mode = "month";
          mode-mon-col = 3;
          on-scroll = 1;
          on-click-right = "mode";

          tooltip-format = "\n<span size='14pt'>{calendar}</span>";
          format = {
            months = "<span color='#5e81ac'><b>{}</b></span>";
            days = "<span color='#88c0d0'><b>{}</b></span>";
            weekdays = "<span color='#d08770'><b>{}</b></span>";
            today = "<span color='#bf616a'><b><u>{}</u></b></span>";
          };
        };
      };
    };
  };
}
