{
  pkgs,
  config,
  ...
}: let
  clrs = config.var.colors;
  thme = config.var.theme;

  backgroundOpacity = builtins.floor (builtins.mul thme.bar.opacity 255);
in {
  # Powerful yet simple to use screenshot software
  home.packages = with pkgs; [
    (flameshot.override {enableWlrSupport = true;})
  ];

  home.file.".config/flameshot/flameshot.ini" = {
    force = true; # Doesn't error if file already exists
    text = ''
      [General]
      contrastOpacity=${toString backgroundOpacity}
      contrastUiColor=${clrs.background}
      uiColor=${clrs.accent}
    '';
  };
}
