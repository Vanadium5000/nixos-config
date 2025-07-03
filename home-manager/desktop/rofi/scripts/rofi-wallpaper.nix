{pkgs, ...}: let
  wallpaperSources = {
    "Nixy Wallpapers" = "${pkgs.nixy-wallpapers}/wallpapers/";
    "Nixos Artwork" = "${pkgs.nixos-wallpapers}/wallpapers/";
  };

  rofi-wallpaper = pkgs.writeShellScriptBin "rofi-wallpaper" ''
    # Kill Rofi if already running
    if pgrep -x "rofi" >/dev/null; then
      pkill rofi
      echo "Rofi already running, exitting"
      exit 0
    fi

    # Nix magic
    result=$(echo "${builtins.concatStringsSep "\n" (builtins.attrNames wallpaperSources ++ ["Choose a file..."])}" | \
    rofi -dmenu)

    echo $result

    declare -A wallpaperSources=(${builtins.concatStringsSep "\n" (map (x: ''["${x}"]="${wallpaperSources.${x}}"'') (builtins.attrNames wallpaperSources))})

    if [[ $result == "Choose a file..." ]];then
      echo "Choosing a specific file"
      wallPath=$(echo $(rofi -run-command "echo {cmd}" -show filebrowser) | cut -d " " -f 2)

      echo "$wallPath"
      swww img "$wallPath"

      # For rofi & hyprlock wallpaper
      cp -f "$wallPath" ~/.current_wallpaper
      exit 0
    fi

    echo "Getting wallDIR"

    wallDIR="''${wallpaperSources["$result"]}"
    echo $wallDIR

    rofi-wallpaper-selector "$wallDIR"

    exit 0
  '';
in {
  home.packages = [rofi-wallpaper];
}
