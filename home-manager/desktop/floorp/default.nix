{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    #./bookmarks.nix
    ./search-engines.nix
  ];

  # Persist browser
  customPersist.home.directories = [ ".floorp" ];

  # Stylix theming for floorp
  stylix.targets.floorp = {
    # The Floorp profile names to apply styling on
    profileNames = [ config.var.username ];

    # Whether to enable theming for Firefox GNOME theme
    firefoxGnomeTheme.enable = true;
  };

  # Browser
  programs.floorp = {
    enable = true;
    languagePacks = [ "en-GB" ];

    package = pkgs.floorp;

    nativeMessagingHosts = [ pkgs.keepassxc ];

    profiles.${config.var.username} = {
      id = 0;
      isDefault = true;

      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        #"signon.rememberSignons" = false;

        "font.name.monospace.x-western" = config.stylix.fonts.monospace.name;
        "font.name.sans-serif.x-western" = config.stylix.fonts.sansSerif.name;
        "font.name.serif.x-western" = config.stylix.fonts.serif.name;
      };

      userChrome = ''
        /* some css */
      '';

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        keepassxc-browser
        ublock-origin
        sponsorblock
        darkreader
        youtube-shorts-block
      ];
    };
  };
}
