{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind =
      [
        "$mod,RETURN, exec, ${pkgs.ghostty}/bin/ghostty" # Ghostty
        "$mod,E, exec, dolphin" # Dolphin
        "$mod,B, exec, ${pkgs.firefox}/bin/firefox" # Firefox
        "$mod,G, exec, xdg-open https://x.com/i/grok" # Open Grok

        "$mod,L, exec, ${pkgs.hyprlock}/bin/hyprlock" # Lock

        "$shiftMod,SPACE, exec, hyprfocus-toggle" # Toggle HyprFocus

        #"$mod,TAB, overview:toggle" # Overview (Hyprspace)

        "$mod,D, exec, toggle-dock" # Toggle nwg-dock-hyprland (dock)
        "$shiftMod,D, exec, waybar-toggle" # Toggle Hyprpanel (bar)

        "$mod,Q, killactive," # Close window
        "$mod,T, togglefloating," # Toggle Floating
        "$mod,F, fullscreen" # Toggle Fullscreen
        "$mod,left, movefocus, l" # Move focus left
        "$mod,right, movefocus, r" # Move focus Right
        "$mod,up, movefocus, u" # Move focus Up
        "$mod,down, movefocus, d" # Move focus Down
        "$shiftMod,up, focusmonitor, -1" # Focus previous monitor
        "$shiftMod,down, focusmonitor, 1" # Focus next monitor
        "$shiftMod,left, layoutmsg, addmaster" # Add to master
        "$shiftMod,right, layoutmsg, removemaster" # Remove from master

        "$mod,PRINT, exec, screenshot area" # Screenshot area & copy/save
        ",PRINT, exec, screenshot monitor" # Screenshot monitor & copy/save
        "$shiftMod,PRINT, exec, screenshot area toText" # Screenshot area & copy as text

        "$mod,F2, exec, night-shift" # Toggle night shift
        "$mod,F3, exec, night-shift" # Toggle night shift

        # Rofi
        "$mod,SPACE, exec, rofi-menu"
        "$mod,Z, exec, clipboard"
        "$mod,V, exec, rofi-vpn"
        "$mod,P, exec, rofi-pass"
        "$shiftMod,E, exec, rofi -show emoji"
        "$mod,W, exec, rofi-wallpaper"
        "$mod,C, exec, rofi -show calc"
        "$mod,X, exec, rofi-powermenu"
        "$mod,S, exec, rofi-screenshot"

        # Screen zooming on shiftMod + mouse_scroll
        "$mod,MINUS, exec, hyprctl keyword cursor:zoom_factor $(awk \"BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.1}\")"
        "$mod,EQUAL, exec, hyprctl keyword cursor:zoom_factor $(awk \"BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.1}\")"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod,code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT,code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));

    bindm = [
      "$mod,mouse:272, movewindow" # Move Window (mouse)
      "$mod, mouse:273, resizewindow" # Resize Window (mouse)
      "$mod ALT, mouse:272, resizewindow" # Resize Window (mouse)
      "$mod,R, resizewindow" # Resize Window (mouse)
    ];

    bindl = [
      ",XF86AudioMute, exec, sound-toggle" # Toggle Mute
      ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause" # Play/Pause Song
      ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next" # Next Song
      ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous" # Previous Song
      ",switch:Lid Switch, exec, ${pkgs.hyprlock}/bin/hyprlock" # Lock when closing Lid
    ];

    bindle = [
      ",XF86AudioRaiseVolume, exec, sound-up" # Sound Up
      ",XF86AudioLowerVolume, exec, sound-down" # Sound Down
      "$shift,XF86AudioRaiseVolume, exec, sound-up-small" # Sound Up Small
      "$shift,XF86AudioLowerVolume, exec, sound-down-small" # Sound Down Small

      ",XF86MonBrightnessUp, exec, brightness-up" # Brightness Up
      ",XF86MonBrightnessDown, exec, brightness-down" # Brightness Down
      "$shift,XF86MonBrightnessUp, exec, brightness-up-small" # Brightness Up Small
      "$shift,XF86MonBrightnessDown, exec, brightness-down-small" # Brightness Down Small

      ",XF86KbdBrightnessUp, exec, brightness-up" # Kbd Brightness Up
      ",XF86KbdBrightnessDown, exec, brightness-down" # Kbd Brightness Down
      "$shift,XF86KbdBrightnessUp, exec, brightness-up-small" # Kbd Brightness Up Small
      "$shift,XF86KbdBrightnessDown, exec, brightness-down-small" # Kbd Brightness Down Small
    ];
  };
}
