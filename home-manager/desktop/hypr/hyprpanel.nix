# Hyprpanel is the bar on top of the screen
# Display informations like workspaces, battery, wifi, ...
{
  pkgs,
  config,
  ...
}: let
  clrs = config.var.colors;
  thme = config.var.theme2;

  backgroundOpacity = builtins.floor (builtins.mul thme.bar.opacity 100);

  fontSize = "${toString config.stylix.fonts.sizes.desktop}";

  borders =
    if thme.bar.borders
    then "true"
    else "false";

  inherit (config.var) location;
  inherit (thme.bar) font;
in {
  imports = [
    ../../../config/theme2.nix
  ];

  wayland.windowManager.hyprland.settings.exec-once = ["${pkgs.hyprpanel}/bin/hyprpanel"];

  home.packages = with pkgs; [
    hyprpanel
    libnotify
    python312Packages.gpustat
  ];

  home.file.".cache/ags/hyprpanel/options.json" = {
    force = true; # Doesn't error if file already exists
    text =
      # json
      ''
        {
          "bar.layouts": {
            "0": {
              "left": [
                "dashboard",
                "clock",
                "media"
              ],
              "middle": [
                "workspaces"
              ],
              "right": [
                "systray",
                "volume",
                "network",
                "bluetooth",
                "battery",
                "notifications"
              ]
            },
            "1": {
              "left": [
                "dashboard",
                "workspaces",
                "windowtitle"
              ],
              "middle": [
                "media"
              ],
              "right": [
                "systray",
                "volume",
                "bluetooth",
                "battery",
                "network",
                "clock",
                "notifications"
              ]
            },
            "2": {
              "left": [
                "dashboard",
                "workspaces",
                "windowtitle"
              ],
              "middle": [
                "media"
              ],
              "right": [
                "systray",
                "volume",
                "bluetooth",
                "battery",
                "network",
                "clock",
                "notifications"
              ]
            }
          },
          "theme.font.name": "${font}",
          "theme.font.size": "${fontSize}px",
          "theme.bar.outer_spacing": "${
          if thme.bar.floating && thme.bar.transparent
          then "0"
          else "2"
        }px",
          "theme.bar.buttons.y_margins": "${
          if thme.bar.floating && thme.bar.transparent
          then "0"
          else "2"
        }px",
          "theme.bar.buttons.spacing": "${thme.bar.spacing.button-gap}",
          "theme.bar.buttons.radius": "${toString thme.button-rounding}px",
          "theme.bar.floating": ${
          if thme.bar.floating
          then "true"
          else "false"
        },
          "theme.bar.buttons.padding_x": "${thme.bar.spacing.button-padding-x}",
          "theme.bar.buttons.padding_y": "${thme.bar.spacing.button-padding-y}",

          "theme.bar.margin_top": "${
          if thme.bar.position == "top"
          then toString (thme.gaps-in * 2)
          else "0"
        }px",
          "theme.bar.margin_bottom": "${
          if thme.bar.position == "top"
          then "0"
          else toString (thme.gaps-in * 2)
        }px",
          "theme.bar.margin_sides": "${toString thme.gaps-out}px",
          "theme.bar.border_radius": "${toString thme.rounding}px",

          "bar.launcher.icon": "",
          "theme.bar.transparent": ${
          if thme.bar.transparent
          then "true"
          else "false"
        },

          "bar.workspaces.workspaces": 6,
          "bar.workspaces.monitorSpecific": true,
          "bar.workspaces.hideUnoccupied": false,
          "bar.windowtitle.label": true,
          "bar.volume.label": true,
          "bar.bluetooth.label": true,
          "bar.clock.format": "%a %b %d  %H:%M:%S",
          "bar.notifications.show_total": true,
          "theme.osd.enable": true,
          "theme.osd.orientation": "vertical",
          "theme.osd.location": "left",
          "theme.osd.margins": "0px 0px 0px 10px",
          "theme.osd.muted_zero": true,

          "menus.clock.weather.location": "${location}",
          "menus.clock.weather.key": "myapikey",
          "menus.clock.weather.unit": "metric",

          "theme.bar.buttons.workspaces.hover": "${clrs.accent-alt}",
          "theme.bar.buttons.workspaces.active": "${clrs.accent}",
          "theme.bar.buttons.workspaces.available": "${clrs.accent-alt}",
          "theme.bar.buttons.workspaces.occupied": "${clrs.accent}",

          "menus.dashboard.powermenu.avatar.image": "${../../../src/NixOS.png}",
          "menus.dashboard.powermenu.confirmation": true,

          "menus.dashboard.shortcuts.left.shortcut1.icon": "",
          "menus.dashboard.shortcuts.left.shortcut1.command": "chromium",
          "menus.dashboard.shortcuts.left.shortcut1.tooltip": "Chromium",
          "menus.dashboard.shortcuts.left.shortcut2.icon": "󰅶",
          "menus.dashboard.shortcuts.left.shortcut2.command": "caffeine",
          "menus.dashboard.shortcuts.left.shortcut2.tooltip": "Caffeine",
          "menus.dashboard.shortcuts.left.shortcut3.icon": "󰖔",
          "menus.dashboard.shortcuts.left.shortcut3.command": "night-shift",
          "menus.dashboard.shortcuts.left.shortcut3.tooltip": "Night-shift",
          "menus.dashboard.shortcuts.left.shortcut4.icon": "",
          "menus.dashboard.shortcuts.left.shortcut4.command": "rofi-menu",
          "menus.dashboard.shortcuts.left.shortcut4.tooltip": "Search Apps",
          "menus.dashboard.shortcuts.right.shortcut1.icon": "",
          "menus.dashboard.shortcuts.right.shortcut1.command": "hyprpicker -a",
          "menus.dashboard.shortcuts.right.shortcut1.tooltip": "Color Picker",
          "menus.dashboard.shortcuts.right.shortcut3.icon": "󰄀",
          "menus.dashboard.shortcuts.right.shortcut3.command": "screenshot area",
          "menus.dashboard.shortcuts.right.shortcut3.tooltip": "Screenshot",

          "menus.dashboard.directories.left.directory1.label": "󰉍 Downloads",
          "menus.dashboard.directories.left.directory1.command": "bash -c \"thunar $HOME/Downloads/\"",
          "menus.dashboard.directories.left.directory2.label": "󰉏 Pictures",
          "menus.dashboard.directories.left.directory2.command": "bash -c \"thunar $HOME/Pictures/\"",
          "menus.dashboard.directories.left.directory3.label": "󱧶 Documents",
          "menus.dashboard.directories.left.directory3.command": "bash -c \"thunar $HOME/Documents/\"",
          "menus.dashboard.directories.right.directory1.label": "󱂵 Home",
          "menus.dashboard.directories.right.directory1.command": "bash -c \"thunar $HOME/\"",
          "menus.dashboard.directories.right.directory2.label": "󰚝 Projects",
          "menus.dashboard.directories.right.directory2.command": "bash -c \"thunar $HOME/dev/\"",
          "menus.dashboard.directories.right.directory3.label": " Config",
          "menus.dashboard.directories.right.directory3.command": "bash -c \"thunar $HOME/.config/\"",

          "theme.bar.menus.monochrome": true,
          "wallpaper.enable": false,
          "theme.bar.menus.background": "${clrs.background}",
          "theme.bar.menus.cards": "${clrs.background-alt}",
          "theme.bar.menus.card_radius": "${toString thme.rounding}px",
          "theme.bar.menus.label": "${clrs.foreground}",
          "theme.bar.menus.text": "${clrs.foreground}",

          "theme.bar.menus.border.size": "${toString thme.border-size}px",
          "theme.bar.border.location": "${
          if thme.bar.bar-border && !thme.bar.transparent
          then "full"
          else "none"
        }",
          "theme.bar.border.width": "${toString thme.border-size}px",
          "theme.bar.menus.border.color": "${clrs.border-color}",
          "theme.bar.border.color": "${clrs.border-color}",
          "theme.bar.buttons.borderColor": "${clrs.border-color}",

          "theme.bar.menus.border.radius": "${toString thme.rounding}px",
          "theme.bar.menus.popover.text": "${clrs.foreground}",
          "theme.bar.menus.popover.background": "${clrs.background-alt}",
          "theme.bar.menus.listitems.active": "${clrs.accent}",
          "theme.bar.menus.icons.active": "${clrs.accent}",
          "theme.bar.menus.switch.enabled":"${clrs.accent}",
          "theme.bar.menus.check_radio_button.active": "${clrs.accent}",
          "theme.bar.menus.buttons.default": "${clrs.accent}",
          "theme.bar.menus.buttons.active": "${clrs.accent}",
          "theme.bar.menus.iconbuttons.active": "${clrs.accent}",
          "theme.bar.menus.progressbar.foreground": "${clrs.accent}",
          "theme.bar.menus.slider.primary": "${clrs.accent}",
          "theme.bar.menus.tooltip.background": "${clrs.background-alt}",
          "theme.bar.menus.tooltip.text": "${clrs.foreground}",
          "theme.bar.menus.dropdownmenu.background":"${clrs.background-alt}",
          "theme.bar.menus.dropdownmenu.text": "${clrs.foreground}",
          "theme.bar.background": "${clrs.background
          + (
            if thme.bar.transparentButtons
            then "" # "00" to make bar transparent if transparentButtons
            else ""
          )}",
          "theme.bar.buttons.style": "${thme.bar.style}",
          "theme.bar.buttons.monochrome": true,
          "theme.bar.buttons.text": "${clrs.foreground}",
          "theme.bar.buttons.background": "${
          (
            if thme.bar.transparent
            then clrs.background
            else clrs.background-alt
          )
          + (
            if thme.bar.transparentButtons
            then "00"
            else ""
          )
        }",
          "theme.bar.buttons.icon": "${clrs.accent}",
          "theme.bar.buttons.hover": "${clrs.background}",
          "theme.osd.bar_color": "${clrs.accent}",
          "theme.osd.bar_overflow_color": "${clrs.accent-alt}",
          "theme.osd.icon": "${clrs.background}",
          "theme.osd.icon_container": "${clrs.accent}",
          "theme.osd.label": "${clrs.accent}",
          "theme.osd.bar_container": "${clrs.background-alt}",
          "theme.bar.menus.menu.media.background.color": "${clrs.background-alt}",
          "theme.bar.menus.menu.media.card.color": "${clrs.background-alt}",
          "theme.bar.menus.menu.media.card.tint": 90,
          "bar.customModules.updates.pollingInterval": 1440000,
          "bar.media.show_active_only": false,
          "theme.bar.location": "${thme.bar.position}",

          "theme.bar.buttons.borderSize": "${toString thme.border-size}px",
          "theme.bar.buttons.enableBorders": ${borders},
          "bar.notifications.hideCountWhenZero": false,

          "menus.dashboard.stats.enable_gpu": true,
          "bar.customModules.ram.labelType": "used/total",

          "theme.bar.buttons.background_opacity": ${toString backgroundOpacity},
          "theme.bar.opacity": ${toString backgroundOpacity},
          "theme.bar.menus.opacity": ${toString backgroundOpacity},
          "bar.media.show_label": false,

          "theme.bar.menus.switch.radius": "${toString thme.rounding}px",
          "theme.bar.menus.switch.slider_radius": "${toString thme.rounding}px",
          "theme.bar.menus.buttons.radius": "${toString thme.rounding}px",
          "theme.bar.menus.progressbar.radius": "${toString thme.rounding}px",
          "theme.bar.menus.slider.slider_radius": "${toString thme.rounding}px",
          "theme.bar.menus.slider.progress_radius": "${toString thme.rounding}px",
          "theme.bar.menus.tooltip.radius": "${toString thme.rounding}px",
          "theme.bar.menus.menu.dashboard.profile.radius": "${toString thme.rounding}px",
          "theme.osd.radius": "${toString thme.rounding}px",

          "theme.bar.buttons.icon_background": "${
          if thme.bar.style == "split"
          then clrs.accent
          else clrs.background
        }",
          "theme.bar.buttons.icon": "${
          if thme.bar.style == "split"
          then clrs.background
          else clrs.accent
        }",


          "theme.bar.buttons.innerRadiusMultiplier": "1",
          "theme.bar.layer": "bottom",
          "theme.bar.dropdownGap": "50px",

          "bar.network.label": true,
          "bar.network.showWifiInfo": true,

          "menus.media.displayTime": true,
          "menus.media.displayTimeTooltip": true,
          "bar.customModules.weather.unit": "metric",

          "menus.clock.time.military": true,
          "menus.bluetooth.showBattery": true
        }
      '';
  };
}
