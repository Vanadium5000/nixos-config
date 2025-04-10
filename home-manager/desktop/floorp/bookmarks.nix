{config, ...}: {
  programs.floorp.profiles.${config.var.username} = {
    bookmarks = [
      {
        name = "wikipedia";
        #toolbar = true;
        tags = ["wiki"];
        keyword = "wiki";
        url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
      }
      {
        name = "Nix sites";
        toolbar = true;
        bookmarks = [
          {
            name = "NixOS Wiki";
            tags = ["wiki" "nix"];
            url = "https://wiki.nixos.org/";
          }
          {
            name = "Home Options";
            tags = ["home-manager" "home"];
            keyword = "home";
            url = "https://nix-community.github.io/home-manager/options.xhtml";
          }
        ];
      }
    ];
  };
}
