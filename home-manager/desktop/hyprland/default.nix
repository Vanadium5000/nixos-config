# So best window tiling manager
{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  clrs = config.var.colors-no-tags;
  thme = config.var.theme;

  inherit (config.var) keyboardLayout;
in {
  imports = [
    ./animations.nix
    ./bindings.nix
    ./decorations.nix
    #./hyprspace.nix
    ./polkitagent.nix
    ./variables.nix
    ./xwayland.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    brightnessctl
    light
    dconf # user-prefs

    hyprpaper # wallpaper util
    hyprpicker # color picker

    nwg-displays # displays/outputs settings gui
    protonvpn-gui # proton vpn gui
  ];

  # Persist nwg-displays diplay settings
  customPersist.home.directories = [".config/hypr/monitors.conf" ".config/hypr/workspaces.conf"];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd = {
      enable = false; # Disables the systemd integration, as it conflicts with uwsm
      variables = ["--all"];
    };

    # set the flake package
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    plugins = [
      #inputs.hyprspace.packages.${pkgs.system}.Hyprspace
    ];

    settings = {
      "$shift" = "SHIFT";
      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";

      exec-once = [
        #"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
      ];

      monitor = [
        ",prefered,auto,auto"
      ];

      cursor = {
        no_hardware_cursors = true;
        #default_monitor = "eDP-2";
      };

      # Fix nwg-displays: an output management utility for sway and Hyprland
      # https://github.com/nwg-piotr/nwg-displays
      source = [
        "~/.config/hypr/monitors.conf"
        "~/.config/hypr/workspaces.conf"
      ];

      general = {
        resize_on_border = true;
        extend_border_grab_area = 6;
        hover_icon_on_border = 1;

        gaps_in = thme.gaps-in;
        gaps_out = thme.gaps-out;
        border_size = thme.border-size;
        #border_part_of_window = true;
        layout = "dwindle"; # or master

        "col.active_border" = lib.mkForce "rgb(${clrs.border-color})";
        "col.inactive_border" = lib.mkForce "rgb(${clrs.border-color-inactive})";
      };

      group = {
        groupbar = {
          "col.active" = lib.mkForce "rgb(${clrs.border-color})";
          "col.inactive" = lib.mkForce "rgb(${clrs.border-color-inactive})";
        };
        "col.border_active" = lib.mkForce "rgb(${clrs.border-color})";
        "col.border_inactive" = lib.mkForce "rgb(${clrs.border-color-inactive})";
      };

      #-------------------------------------------------------------
      #                      Dwindle layout
      #-------------------------------------------------------------
      dwindle = {
        #pseudotile = 0 # enable pseudotiling on dwindle
        pseudotile = "yes";
        preserve_split = "yes";
        smart_split = "no";
        special_scale_factor = 1.0;
      };

      master = {
        new_status = true;
        allow_small_split = true;
        mfact = 0.5;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        vfr = true;
        vrr = 1; # 0 | 1 | 2

        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = false;

        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2; # 0 | 1 | 2
      };

      windowrulev2 = [
        "float, tag:modal"
        "pin, tag:modal"
        "center, tag:modal"

        # Fix flameshot
        # https://wiki.hyprland.org/FAQ/
        "noanim, class:^(flameshot)$"
        "float, class:^(flameshot)$"
        "move 0 0, class:^(flameshot)$"
        "pin, class:^(flameshot)$"
      ];

      layerrule = [
        "noanim, launcher"
        "noanim, rofi"

        # Hyprpanel
        "noanim, ^bar-([0-9]*)$"
        "blur, ^bar-([0-9]*)$"
        "blurpopups, ^bar-([0-9]*)$"
        # Hyprpanel menus
        "noanim, ^([a-z]*)menu$"
        "blur, ^([a-z]*)menu$"
        "ignorezero, ^([a-z]*)menu$" # makes blur ignore fully transparent pixels
        #"blurpopups, ^([a-z]*)menu$"

        # Waybar
        "noanim, ^waybar$"
        "blur, ^waybar$"
        "ignorezero, ^waybar$" # makes blur ignore fully transparent pixels

        # Nwg-dock-hyprland
        "noanim, ^nwg-dock$"
        "blur, ^nwg-dock$"
        "ignorezero, ^nwg-dock$" # makes blur ignore fully transparent pixels
      ];

      cursor = {
        inactive_timeout = 10.0; # time to wait before hiding cursor
      };

      input = {
        kb_layout = keyboardLayout;
        #kb_options = "caps:escape";

        follow_mouse = 1;

        sensitivity = 0.5;
        repeat_delay = 300;
        repeat_rate = 50;
        numlock_by_default = true;

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
        };
      };
    };
  };
  #systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
}
