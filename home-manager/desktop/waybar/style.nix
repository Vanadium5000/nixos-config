{ config, ... }:
let
  font = config.stylix.fonts.monospace.name;
  fontSize = config.stylix.fonts.sizes.desktop;

  radius = toString thme.button-rounding;
  width = toString thme.border-size;

  clrs-rgba = config.var.colors-rgba thme.bar.opacity;
  clrs = config.var.colors;

  thme = config.var.theme;
in
{
  # CSS style of the bar
  # https://github.com/gzowski/public_configs/blob/main/.config/waybar/style.css
  programs.waybar.style =
    # with config.lib.stylix.colors.withHashtag;
    ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: '${font}';
          /* font-size: ${toString fontSize}px; */

          /* Reset all styles */
          border-radius: ${radius}px;
          min-height: 0;
          margin: 0;
      }

      window#waybar {
          background-color: ${clrs-rgba.background};
          color: ${clrs.foreground};

          border: ${width}px solid ${clrs.border-color};
          border-radius: ${toString thme.rounding}px;
      }

      .modules-right {
          margin: 0 5px 0 0;
      }
      .modules-center {
          margin: 0px 0 0 0;
      }
      .modules-left {
          margin: 0 0 0 5px;
      }

      #custom-logo,
      #cava,
      #window,
      #clock,
      #monitoring, /* group */
      #actions, /* group */
      #system, /* group */
      #custom-notifications,
      #custom-recording,
      #tray,
      #network,
      #workspaces,
      #media,
      #load {
          margin: ${width}px ${toString thme.gaps-in} ${width}px ${toString thme.gaps-in};
          padding-left: 3px;
          padding-right: 3px;
          background-color: ${clrs.background-alt};
          color: ${clrs.foreground};
          /* border: ${width}px solid ${clrs.border-color};
          border-radius: ${radius}px; */
      }

      #workspaces button {
          padding: 0;
          background-color: transparent;
          color: ${clrs.foreground};
          border-radius: 0;
      }


      #workspaces button:first-child {
          border-radius: ${radius}px 0 0 ${radius}px;
      }

      #workspaces button:last-child {
          border-radius: 0 ${radius}px ${radius}px 0;
      }

      #workspaces button:hover {
          color: ${clrs.foreground-alt};
      }

      #workspaces button.focused {
          background-color: ${clrs.accent};
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #battery.charging, #battery.plugged {
          /* background-color: ${clrs-rgba.background}; */
          color: #00FF00;
      }

      @keyframes blink {
          to {
              background-color: ${clrs-rgba.background};
              color: ${clrs.foreground};
          }
      }

      /* Using steps() instead of linear as a timing function to limit cpu usage */
      /* Urgent red styling for critical battery or active recording */
      #battery.critical:not(.charging), #custom-recording.recording-active {
          background-color: #cc241d;
          color: ${clrs.foreground};
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #backlight-slider slider,
      #pulseaudio-slider slider {
        background: #A1BDCE;
        background-color: transparent;
        box-shadow: none;
        margin-right: 7px;
      }

      #backlight-slider trough,
      #pulseaudio-slider trough {
        margin-top: -3px;
        min-width: 90px;
        min-height: 10px;
        margin-bottom: -4px;
        border-radius: 8px;
        background: #343434;
      }

      #backlight-slider highlight,
      #pulseaudio-slider highlight {
        border-radius: 8px;
        background-color: #2096C0;
      }
    '';
}
