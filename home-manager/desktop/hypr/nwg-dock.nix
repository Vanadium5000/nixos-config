{
  config,
  pkgs,
  ...
}: let
  fontSize = config.stylix.fonts.sizes.desktop;

  clrs-rgba = config.var.colors-rgba thme.bar.opacity;
  clrs = config.var.colors;

  thme = config.var.theme;

  # -x: move other windows aside
  # -m*: margin bottom, left, right, top
  # -f: full-length
  # -p: position (left)
  # -a: alignment of icons
  spawn-dock = pkgs.writeShellScriptBin "spawn-dock" ''
    if [ -n "$(pgrep nwg-dock)" ]; then
      echo "nwg-dock is already running"
    else
      hyprctl dispatch exec "nwg-dock-hyprland -x -mb 0 -ml 0 -mr 0 -mt 0 -f -p left -a start"
    fi
  '';

  toggle-dock = pkgs.writeShellScriptBin "toggle-dock" ''
    if [ -n "$(pgrep nwg-dock)" ]; then
      pkill nwg-dock
    else
      hyprctl dispatch exec "nwg-dock-hyprland -x -mb 0 -ml 0 -mr 0 -mt 0 -f -p left -a start"
    fi
  '';
in {
  home.packages = [
    spawn-dock
    toggle-dock
    pkgs.nwg-dock-hyprland
  ];

  wayland.windowManager.hyprland.settings.exec-once = ["spawn-dock"];

  home.file.".config/nwg-dock-hyprland/style.css".text = ''
    window {
        background: ${clrs-rgba.background};
    	border-radius: ${toString thme.button-rounding}px;
    	border-style: solid;
    	border-width: ${
      if thme.bar.borders
      then toString thme.border-size
      else "0"
    }px;
    	border-color: ${clrs-rgba.border-color};
    }

    #box {
        /* Define attributes of the box surrounding icons here */
        padding: ${toString thme.gaps-in}px;
    }

    #active {
    	/* This is to underline the button representing the currently active window */
    	/*border-bottom: solid 1px;
    	border-color: ${clrs.border-color};*/
    }

    button, image {
    	background: none;
    	border-style: none;
    	box-shadow: none;
    	color: #999;
    }

    button {
    	padding: 4px;
    	margin-left: 0;
    	margin-right: 0;
        font-size: ${toString fontSize}px;
    }

    button:hover {
    	background-color: rgba(255, 255, 255, 0.15);
    	border-radius: ${toString thme.button-rounding}px;
    }

    button:focus {
    	box-shadow: none;
    }'';
}
