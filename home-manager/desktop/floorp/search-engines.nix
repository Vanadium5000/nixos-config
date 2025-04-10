{
  pkgs,
  config,
  ...
}: {
  programs.floorp.profiles.${config.var.username}.search = {
    default = "Startpage";
    privateDefault = "Startpage";

    engines = {
      "Nix Packages" = {
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = ["@np"];
      };

      "Home Manager Settings" = {
        urls = [
          {
            template = "https://home-manager-options.extranix.com";
            params = [
              {
                name = "release";
                value = "master";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];

        icon = "https://home-manager-options.extranix.com/images/favicon.png";
        definedAliases = ["@hm"];
      };

      "NixOS Wiki" = {
        urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
        icon = "https://wiki.nixos.org/favicon.ico";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = ["@nw"];
      };

      "Brave" = {
        urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
        icon = "https://brave.com/static-assets/images/brave-favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = ["@b"];
      };

      "youtube" = {
        urls = [
          {
            template = "https://www.youtube.com/results";
            params = [
              {
                name = "search_query";
                value = "{searchTerms}";
              }
            ];
          }
        ];

        icon = "https://www.youtube.com/s/desktop/508deff1/img/logos/favicon_96x96.png";
        definedAliases = ["@yt"];
      };

      "Startpage" = {
        urls = [
          {
            template = "https://www.startpage.com/sp/search";
            params = [
              {
                name = "query";
                value = "{searchTerms}";
              }
              {
                name = "prfe";
                value = "743101ebd7e315de9ac59028ce09604d4900b5494135134d1e1fdec95b04faeb29e4b3fca16baf9b7782d63867ca1ae534c736487b8ffa4cbc73a298f214a2e82f1a63957d37c51be1c5fd4b";
              }
            ];
          }
        ];

        icon = "https://www.startpage.com/sp/cdn/favicons/favicon-96x96.png";
        definedAliases = ["@sp"];
      };

      "GitHub" = {
        urls = [
          {
            template = "https://github.com/search";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
              {
                name = "type";
                value = "repositories";
              }
            ];
          }
        ];

        icon = "https://github.githubassets.com/favicons/favicon.png";
        definedAliases = ["@gh"];
      };

      "bing".metaData.hidden = true;
      "ddg".metaData.hidden = true;
      "ebay".metaData.hidden = true;
      "You.com".metaData.hidden = true;
    };

    # Engines that aren’t included in this list will be listed after these in an unspecified order
    order = ["ddg" "Nix Packages" "Wikipedia"];

    # # Whether to force replace the existing search configuration, recommended
    force = true;
  };
}
