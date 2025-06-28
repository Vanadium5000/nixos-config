{
  pkgs,
  config,
  ...
}: {
  programs.firefox.profiles.${config.var.username}.search = {
    default = "startpage";
    privateDefault = "startpage";
    # Whether to force replace the existing search configuration, recommended
    force = true;

    engines = {
      "startpage" = {
        name = "Startpage";
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

        icon = "https://www.startpage.com/sp/cdn/favicons/favicon-gradient.ico";
        definedAliases = ["@sp"];
      };

      "github" = {
        name = "GitHub";
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
  };
}
