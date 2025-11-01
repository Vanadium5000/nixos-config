{
  config,
  pkgs,
  ...
}:
let
  fontSize = config.stylix.fonts.sizes.desktop;

  clrs-rgba = config.var.colors-rgba thme.bar.opacity;
  clrs = config.var.colors;

  thme = config.var.theme;

  toggle-nwg-drawer = pkgs.writeShellScriptBin "toggle-nwg-drawer" ''
    if pgrep nwg-drawer > /dev/null; then
      pkill nwg-drawer
    else
      ${pkgs.nwg-drawer}/bin/nwg-drawer -c 8 -wm "hyprland" -mb ${toString thme.gaps-in} -ml ${toString thme.gaps-in} -mr ${toString thme.gaps-in} -mt ${toString thme.gaps-in}
    fi
  '';

  toggle-dock = pkgs.writeShellScriptBin "toggle-dock" ''
    # Check if nwg-dock-hyprland service is active
    if systemctl --user is-active --quiet nwg-dock-hyprland.service; then
        # If active, stop the service
        systemctl --user stop nwg-dock-hyprland.service
        echo "nwg-dock-hyprland has been stopped."
    else
        # If inactive, start the service
        systemctl --user start nwg-dock-hyprland.service
        echo "nwg-dock-hyprland has been started."
    fi
  '';

in
{
  home.packages = [
    toggle-dock
    toggle-nwg-drawer
    pkgs.nwg-dock-hyprland
  ];

  # Persist pinned apps
  customPersist.home.files = [ ".cache/nwg-dock-pinned" ];

  # Service to start nwg-dock-hyprland
  systemd.user.services.nwg-dock-hyprland = {
    Unit = {
      Description = "Autostart nwg-dock-hyprland";
      # Stop nwg-dock-hyprland taking any of waybars space because it is spawned first
      After = [ "waybar.service" ]; # Ensures nwg-dock-hyprland starts after waybar
      BindsTo = [ "waybar.service" ]; # Binds the service lifecycle to waybar (restarts when waybar restarts)
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      # Start command
      # -x: move other windows aside
      # -m*: margin bottom, left, right, top
      # -f: full-length
      # -p: position (left)
      # -a: alignment of icons
      ExecStart = pkgs.writeShellScript "nwg-dock-hyprland-start" ''
        ${pkgs.nwg-dock-hyprland}/bin/nwg-dock-hyprland -x -mb ${toString thme.gaps-out} -ml ${toString thme.gaps-out} -mr 0 -mt ${toString thme.gaps-out} -f -p left -c "${toggle-nwg-drawer}/bin/toggle-nwg-drawer" -a start -i 34
      '';
      Restart = "on-failure"; # Optional: restart on failure
    };
  };

  home.file.".config/nwg-drawer/drawer.css".text = ''
    window {
        background-color: ${clrs-rgba.background};
        border-radius: ${toString thme.rounding}px;
    	  border-style: solid;
    	  border-width: ${if thme.bar.borders then toString thme.border-size else "0"}px;
    	  border-color: ${clrs.border-color};
        color: #999
    }

    /* search entry */
    entry {
        background-color: rgba(0, 0, 0, 0.2)
    }

    button {
        /* background: none; */
        background-image: linear-gradient(to bottom, rgba(255,255,255,0.25)0%, rgba(0,0,0,0.5)50%, rgba(0,0,0,0.8)50%);
        border: none
    }

    image {
        border: none
    }

    button:hover {
        background-color: rgba(255, 255, 255, 0.15)
    }

    /* in case you wanted to give category buttons a different look */
    #category-button {
        margin: 0 10px 0 10px
    }

    #pinned-box {
        padding-bottom: 5px;
        border-bottom: 1px #000000
    }

    #files-box {
        padding: 5px;
        border: 1px #000000;
        border-radius: ${toString thme.rounding}
    }

    /* math operation result label */
    #math-label {
        font-weight: bold;
        font-size: 16px
    }
  '';

  home.file.".config/nwg-dock-hyprland/style.css".text = ''
    window {
      background: rgba(0,0,0,0.8);
    	border-radius: ${toString thme.rounding}px;
    	border-style: solid;
    	border-width: ${if thme.bar.borders then toString thme.border-size else "0"}px;
    	border-color: ${clrs.border-color};
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
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.25)0%, rgba(0,0,0,0.5)50%, rgba(0,0,0,0.8)50%);
    	padding: 3px;
      margin: 3px;
    	margin-left: 2px;
    	margin-right: 2px;
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
