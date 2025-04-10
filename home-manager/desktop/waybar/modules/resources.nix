_: {
  # https://github.com/ashish-kus/waybar-minimal/blob/main/src/config.jsonc
  # Options: https://github.com/Alexays/Waybar/wiki/Configuration
  programs.waybar.settings = {
    mainBar = {
      disk = {
        interval = 300;
        format = " {percentage_used}%";
        path = "/";
      };
      cpu = {
        interval = 10;
        format = " {usage}%";
      };
      memory = {
        interval = 10;
        format = " {used:0.1f}G/{total:0.1f}G";
      };
      temperature = {
        format = " {temperatureC}°C";
        format-critical = " {temperatureC}°C";
        interval = 5;
        critical-threshold = 80;
        on-click = "foot btop";
      };
      "custom/powerDraw" = {
        format = "{}";
        interval = 5;
        exec = "powerdraw";
        return-type = "json";
      };
      "group/monitoring" = {
        orientation = "horizontal";
        modules = [
          "cpu"
          "memory"
          #"temperature" # Not very useful
          "custom/powerDraw"
          #"network#speed"
          #"custom/weather" # broken
        ];
      };
    };
  };
}
