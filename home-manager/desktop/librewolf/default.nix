{
  pkgs,
  config,
  ...
}:
{
  imports = [
    #./bookmarks.nix
    ./search-engines.nix
  ];

  # Persist browser
  customPersist.home.directories = [ ".librewolf" ];

  # Stylix theming for floorp
  stylix.targets.librewolf = {
    # The Floorp profile names to apply styling on
    profileNames = [ config.var.username ];

    # Whether to enable theming for Firefox GNOME theme
    firefoxGnomeTheme.enable = true;
  };

  # Browser
  # TODO: Multi-account containers
  programs.librewolf = {
    enable = true;

    package = pkgs.librewolf;

    nativeMessagingHosts = [
      #pkgs.keepassxc
      #pkgs.passff-host
    ];

    profiles.${config.var.username} = {
      id = 0;
      isDefault = true;

      settings = {
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "expand-on-hover";
        "layout.spellcheckDefault" = 0; # Disable spellcheck - use Harper spellcheck instead
        "widget.gtk.overlay-scrollbars.enabled" = false; # Always show scrollbars
        "layout.css.always_underline_links" = true;

        # Don't suggest stuff in the urlbar
        "browser.urlbar.suggest.history" = false;

        # Re-enable browser rendering stuff
        "webgl.disabled" = false;

        # Disable annoying swipe gestures (alt + left/right arrow is so much easier)
        "browser.gesture.swipe.left" = "";
        "browser.gesture.swipe.right" = "";
      };

      # /*
      #   2815: set "Cookies" and "Site Data" to clear on shutdown (if 2810 is true) [SETUP-CHROME] [FF128+]
      #     * [NOTE] Exceptions: For cross-domain logins, add exceptions for both sites
      #     * e.g. https://www.youtube.com (site) + https://accounts.google.com (single sign on)
      #     * [WARNING] Be selective with what sites you "Allow", as they also disable partitioning (1767271)
      #     * [SETTING] to add site exceptions: Ctrl+I>Permissions>Cookies>Allow (when on the website in question)
      #     * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Settings **
      # */
      # extraConfig =
      #   (lib.fileContents "${pkgs.arkenfox-userjs}/user.js")
      #   # Overrides
      #   + ''
      #     // Overrides go here
      #   '';

      userChrome = ''
        /* some css */
        /*menupopup, panel {
          transition: unset !important;
        }*/
      '';

      # TODO: Add Vencord, probably swap tampermonkey with something lighter
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        # Ad block
        ublock-origin

        # Bookmarks & tabs sync across browsers any WebDAV or Git service,
        # via local file, Nextcloud, or Google Drive
        floccus

        # Dark mode for every website
        darkreader

        # YouTube enhancements
        sponsorblock
        return-youtube-dislikes
        #youtube-enhancer-vc # Block YT shorts & general improvements

        tampermonkey # Userscripts
        private-grammar-checker-harper # Private spellcheck
        #styl-us # Userstyles (CSS) manager
      ];
    };
  };

  # Custom option
  allowedUnfree = [
    "tampermonkey"
  ];
}
