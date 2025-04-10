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
    pluginName = "cpu";
    version = "unstable-2025-01-10";
    src = fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-cpu";
      rev = "bcb110d754ab2417de824c464730c412a3eb2769";
      sha256 = "sha256-OrQAPVJHM9ZACyN36tlUDO7l213tX2a5lewDon8lauc=";
    };
  }
