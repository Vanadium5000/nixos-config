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
        ${pkgs.nwg-dock-hyprland}/bin/nwg-dock-hyprland -x -mb ${toString thme.gaps-out} -ml ${toString thme.gaps-out} -mr 0 -mt ${toString thme.gaps-out} -f -p left -a start -i 38
      '';
    };
  };

  home.file.".config/nwg-dock-hyprland/style.css".text = ''
    window {
      background: ${clrs-rgba.background};
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
