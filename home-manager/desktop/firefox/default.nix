{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    #./bookmarks.nix
    ./search-engines.nix
  ];

  # Persist browser
  customPersist.home.directories = [ ".mozilla" ];

  # Stylix theming for floorp
  stylix.targets.firefox = {
    # The Floorp profile names to apply styling on
    profileNames = [ config.var.username ];

    # Whether to enable theming for Firefox GNOME theme
    firefoxGnomeTheme.enable = true;
  };

  # Browser
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" ];

    package = pkgs.firefox;

    nativeMessagingHosts = [
      #pkgs.keepassxc
      #pkgs.passff-host
    ];

    profiles.${config.var.username} = {
      id = 0;
      isDefault = true;

      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        #"signon.rememberSignons" = false;

        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      };

      /*
        2815: set "Cookies" and "Site Data" to clear on shutdown (if 2810 is true) [SETUP-CHROME] [FF128+]
          * [NOTE] Exceptions: For cross-domain logins, add exceptions for both sites
          * e.g. https://www.youtube.com (site) + https://accounts.google.com (single sign on)
          * [WARNING] Be selective with what sites you "Allow", as they also disable partitioning (1767271)
          * [SETTING] to add site exceptions: Ctrl+I>Permissions>Cookies>Allow (when on the website in question)
          * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Settings **
      */
      extraConfig =
        (lib.fileContents "${pkgs.arkenfox-userjs}/user.js")
        # Overrides
        + ''
          // Overrides go here
        '';

      userChrome = ''
        /* some css */
        /*menupopup, panel {
          transition: unset !important;
        }*/
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
