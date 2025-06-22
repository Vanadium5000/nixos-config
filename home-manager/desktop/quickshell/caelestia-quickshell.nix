{pkgs, ...}: {
  home.packages = with pkgs; [
    # Wrapper for caelestia to work with quickshell
    (writeScriptBin "caelestia-quickshell" ''
      #!${pkgs.fish}/bin/fish

      # Override for caelestia shell commands to work with quickshell
      set -l original_caelestia $(which caelestia)

      if test "$argv[1]" = "shell" -a -n "$argv[2]"
          set -l cmd $argv[2]
          set -l args $argv[3..]

          switch $cmd
              case "show" "toggle"
                  if test -n "$args[1]"
                      exec qs -c caelestia ipc call drawers $cmd $args[1]
                  else
                      echo "Usage: caelestia shell $cmd <drawer>"
                      exit 1
                  end
              case "media"
                  if test -n "$args[1]"
                      set -l action $args[1]
                      switch $action
                          case "play-pause"
                              exec qs -c caelestia ipc call mpris playPause
                          case '*'
                              exec qs -c caelestia ipc call mpris $action
                      end
                  else
                      echo "Usage: caelestia shell media <action>"
                      exit 1
                  end
              case '*'
                  # For other shell commands, try the original
                  exec $original_caelestia $argv
          end
      else
          # For non-shell commands, use the original
          exec $original_caelestia $argv
      end
    '')
  ];
}
