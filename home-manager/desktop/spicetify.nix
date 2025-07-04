# Spicetify is a spotify client customizer
{
  pkgs,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  stylix.targets.spicetify.enable = true;

  programs.spicetify = {
    enable = true;
    #theme = lib.mkForce spicePkgs.themes.text;

    enabledExtensions = with spicePkgs.extensions; [
      playlistIcons
      lastfm
      historyShortcut
      hidePodcasts
      adblock
      fullAppDisplay
      shuffle
    ];
  };
}
