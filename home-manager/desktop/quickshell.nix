{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
      inputs.quickshell.packages.${pkgs.system}.default
      fish
      jq
      fd
      cava
      bluez
      ddcutil
      brightnessctl
      curl
      material-symbols
      python3
    ]
    ++ (with python312Packages; [
      aubio
      pyaudio
      numpy
    ]);

  xdg.configFile."quickshell/caelestia".source = "${inputs.caelestia-shell}";
}
