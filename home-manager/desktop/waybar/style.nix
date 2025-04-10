{config, ...}: let
  font = config.stylix.fonts.sansSerif.name;
  fontSize = config.stylix.fonts.sizes.desktop;

  radius = toString thme.button-rounding;
  width = toString thme.border-size;
  border-color = config.var.colors.border-color;

  clrs = config.var.colors-rgba thme.bar.opacity;
  thme = config.var.theme;
in {
  # CSS style of the bar
  # https://github.com/gzowski/public_configs/blob/main/.config/waybar/style.css
  programs.waybar.style = with config.lib.stylix.colors.withHashtag; ''
    @define-color base00 ${base00}; @define-color base01 ${base01}; @define-color base02 ${base02}; @define-color base03 ${base03};
    @define-color base04 ${base04}; @define-color base05 ${base05}; @define-color base06 ${base06}; @define-color base07 ${base07};

    @define-color base08 ${base08}; @define-color base09 ${base09}; @define-color base0A ${base0A}; @define-color base0B ${base0B};
    @define-color base0C ${base0C}; @define-color base0D ${base0D}; @define-color base0E ${base0E}; @define-color base0F ${base0F};

    * {
        border: 0px;
        font-family: '${font} Bold';
        font-size: ${toString fontSize}px;
        min-height: 0px;
    }

    window > box {
        margin: ${toString (thme.gaps-in * 2)} ${toString thme.gaps-in} 0px ${toString thme.gaps-in};
        background-color: rgba(0,0,0,0);
    }
    window#waybar {
        background-color: rgba(0,0,0,0);
        color: @color7;
    }
    #workspaces button {
        border-radius: 0px;
        color: @color7;
    }
    #workspaces {
        color: @color7;
        border: 0px;
        box-shadow: inherit;
    }

    #workspaces button {
        background-color: transparent;
        color: @color8;
    }
    #workspaces button:hover {
        color: @color4;
        background-color: transparent;
    }
    #workspaces button.visible {
        color: @color7;
    }
    #workspaces button.focused {
        color: @color8;
    }
    #workspaces button.active {
        color: @color7;
    }
    #workspaces button.urgent {
        color: @color1;
    }
    .modules-center {
    }
    .modules-left {
    }
    .modules-right {
    }
    #tray,
    #mode,
    #window,
    #temperature,
    #temperature.critical,
    #clock,
    #cpu,
    #pulseaudio,
    #disk,
    #custom-dot,
    #custom-os_button,
    #custom-vpnstatus,
    #workspaces,
    #custom-updates,
    #taskbar,
    #mpris
    {
    background-color: ${clrs.background};
      border-radius: ${radius}px;
      border-top: ${width} solid ${border-color};
      border-left: ${width} solid ${border-color};
      border-right: ${width} solid ${border-color};
      border-bottom: ${width} solid ${border-color};
      padding-left: 10px;
      padding-right: 10px;
      margin-left: ${toString thme.gaps-in};
      margin-right: ${toString thme.gaps-in};
    }
    @keyframes blink {
        to {
            background-color: @color0;
            color: @color7;
        }
    }
    label:focus {
    }
    #custom-dot {
      padding-top: 0px;
      color: @color4;
    }
    #custom-vpnstatus {
      color: @color1;
      font-size: 20px;
    }
    #custom-spotify {
    }
    #memory {
    }
    #pulseaudio {
    }
    #pulseaudio.muted {
    }
    #tray {
    }
    #disk {
    }
    #window {
    }
    #clock {
    }
  '';
}
