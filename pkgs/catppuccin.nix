{
  lib,
  fetchFromGitHub,
  pkgs,
  stdenv,
  ...
}: let
  rtpPath = "share/tmux-plugins";

  addRtp = path: rtpFilePath: attrs: derivation:
    derivation
    // {rtp = "${derivation}/${path}/${rtpFilePath}";}
    // {
      overrideAttrs = f: mkTmuxPlugin (attrs // f attrs);
    };

  mkTmuxPlugin = a @ {
    pluginName,
    rtpFilePath ? (builtins.replaceStrings ["-"] ["_"] pluginName) + ".tmux",
    namePrefix ? "tmuxplugin-",
    src,
    unpackPhase ? "",
    configurePhase ? ":",
    buildPhase ? ":",
    addonInfo ? null,
    preInstall ? "",
    postInstall ? "",
    path ? lib.getName pluginName,
    ...
  }:
    if lib.hasAttr "dependencies" a
    then throw "dependencies attribute is obselete. see NixOS/nixpkgs#118034" # added 2021-04-01
    else
      addRtp "${rtpPath}/${path}" rtpFilePath a (stdenv.mkDerivation (a
        // {
          pname = namePrefix + pluginName;

          inherit pluginName unpackPhase configurePhase buildPhase addonInfo preInstall postInstall;

          installPhase = ''
            runHook preInstall

            target=$out/${rtpPath}/${path}
            mkdir -p $out/${rtpPath}
            cp -r . $target
            if [ -n "$addonInfo" ]; then
              echo "$addonInfo" > $target/addon-info.json
            fi

            runHook postInstall
          '';
        }));
in
  mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "unstable-2025-01-10";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "ba9bd88c98c81f25060f051ed983e40f82fdd3ba";
      hash = "sha256-HegD89d0HUJ7dHKWPkiJCIApPY/yqgYusn7e1LDYS6c=";
    };
    postInstall = ''
      sed -i -e 's|''${PLUGIN_DIR}/catppuccin-selected-theme.tmuxtheme|''${TMUX_TMPDIR}/catppuccin-selected-theme.tmuxtheme|g' $target/catppuccin.tmux
    '';
    meta = with lib; {
      homepage = "https://github.com/catppuccin/tmux";
      description = "Soothing pastel theme for Tmux!";
      license = licenses.mit;
      platforms = platforms.unix;
      maintainers = with maintainers; [jnsgruk];
    };
  }
