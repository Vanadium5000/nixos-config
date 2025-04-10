{pkgs, ...}: let
  album_art = pkgs.writeShellScriptBin "album_art" ''
    album_art=$(playerctl -p spotify metadata mpris:artUrl)
    if [[ -z $album_art ]]
    then
       # spotify is dead, we should die too.
       exit
    fi
    curl -s  "''${album_art}" --output "/tmp/cover.jpeg"
    echo "/tmp/cover.jpeg"
  '';
in {
  # Options: https://github.com/Alexays/Waybar/wiki/Configuration
  programs.waybar.settings = {
    mainBar = {
      mpris = {
        format = "{status_icon} {position}/{length}";
        format-paused = "{status_icon} {position}/{length}";
        interval = 1;
        status-icons = {
          playing = "󰐊";
          paused = "󰏤";
        };
      };
      "image#album-art" = {
        exec = "album_art";
        size = 24;
        interval = 30;
      };
      "group/media" = {
        orientation = "horizontal";
        modules = [
          "image#album-art"
          "mpris"
        ];
      };
    };
  };

  home.packages = [
    album_art
  ];
}
