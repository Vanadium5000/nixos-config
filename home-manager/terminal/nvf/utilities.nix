_: {
  programs.nvf.settings.vim = {
    utility = {
      ccc.enable = false;
      vim-wakatime.enable = false;

      # Maximal
      icon-picker.enable = true;
      surround.enable = true;

      diffview-nvim.enable = true;
      motion = {
        hop.enable = true;
        leap.enable = true;
      };

      images = {
        image-nvim = {
          enable = true; # Image support
          # Kitty is much faster
          setupOpts.backend = "kitty"; # "kitty" | "ueberzug"
        };
      };
    };
  };
}
