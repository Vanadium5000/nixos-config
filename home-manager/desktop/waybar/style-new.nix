{config, ...}: let
  font = config.stylix.fonts.monospace.name;
  fontSize = config.stylix.fonts.sizes.desktop;

  radius = toString thme.button-rounding;
  width = toString thme.border-size;
  border-color = config.var.colors.border-color;

  clrs-rgba = config.var.colors-rgba thme.bar.opacity;
  clrs = config.var.colors;

  thme = config.var.theme;
in {
  # CSS style of the bar
  # https://github.com/gzowski/public_configs/blob/main/.config/waybar/style.css
  programs.waybar.style = with config.lib.stylix.colors.withHashtag; ''
    * {
        font-size: ${toString fontSize}px;
        border-radius: ${toString thme.button-rounding}px;
        min-height: 0;
    }

    window#waybar {
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: '${font}';
        /* background-color: ${clrs-rgba.background-alt}; */
        background-color: transparent;
        border-bottom: 0px;
        color: ${clrs.foreground};
        transition-property: background-color;
        transition-duration: .5s;
    }

    window#waybar.hidden {
        opacity: 0.2;
    }

    window#waybar.empty #window {
        background-color: transparent;
    }

    /*
    window#waybar.empty {
        background-color: transparent;
    }
    window#waybar.solo {
        background-color: #FFFFFF;
    }
    */

    .modules-right {
        /* margin: 0px ${toString thme.gaps-out}px 0 0; */
        margin: 0 0 0 0;
    }
    .modules-center {
        margin: 0px 0 0 0;
    }
    .modules-left {
        /* margin: 0px 0 0 ${toString thme.gaps-out}px; */
        margin: 0 0 0 0;
    }

    button {
        /* Use box-shadow instead of border so the text isn't offset */
        /* box-shadow: inset 0 -3px transparent; */
        border: none;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    /*
    button:hover {
        background: inherit;
        box-shadow: inset 0 -3px #ebdbb2;
    } */

    #workspaces {
        background-color: ${clrs-rgba.background};
    }

    #workspaces button {
        padding: 3px 5px;
        background-color: transparent;
        color: ${clrs.foreground};
        border-radius: 0;
    }

    #workspaces button:first-child {
        border-radius: ${toString thme.button-rounding}px 0 0 ${toString thme.button-rounding}px;
    }

    #workspaces button:last-child {
        border-radius: 0 ${toString thme.button-rounding}px ${toString thme.button-rounding}px 0;
    }

    #workspaces button:hover {
        color: ${clrs.foreground-alt};
    }

    #workspaces button.focused {
        background-color: ${clrs.accent};
        /* box-shadow: inset 0 -3px #ffffff; */
    }

    #custom-logo {
        padding: 0 10px;
        background-color: ${clrs.accent};
        color: ${clrs.background};
        border-radius: 0 0 0 0;
    }

    #cava,
    #window,
    #clock,
    #monitoring, /* group */
    #actions, /* group */
    #system, /* group */
    #custom-notifications,
    #tray,
    #network,
    #workspaces,
    #media,
    #load {
        padding: 3px 5px;
        margin-left: 0px;
        background-color: ${clrs-rgba.background};
        color: ${clrs.foreground};
        border: ${
      toString
      (
        if thme.bar.borders
        then thme.border-size
        else 0
      )
    }px solid ${clrs.border-color};
    }

    #mode {
        background-color: #689d6a;
        color: ${clrs-rgba.background};
        /* box-shadow: inset 0 -3px #ffffff; */
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
    #battery.critical:not(.charging) {
        background-color: #cc241d;
        color: ${clrs.foreground};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #tray > .passive {
        -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
        -gtk-icon-effect: highlight;
    }

    #tray menu {
        font-family: sans-serif;
    }
  '';
}
