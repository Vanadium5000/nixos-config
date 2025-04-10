_: {
  programs.nvf.settings.vim = {
    theme = {
      enable = true;
      # name = "catppuccin";
      # style = "mocha";
      transparent = true;
    };

    ui = {
      borders.enable = true;
      noice.enable = true; # popup cmd line
      colorizer.enable = true; # colorizer for hexcodes, etc.
      modes-nvim.enable = false; # the theme looks terrible with catppuccin
      illuminate.enable = true; # highlight similar symbols
      breadcrumbs = {
        # Maximal
        enable = true;
        navbuddy.enable = true; # popup symbol overview
      };
      # A Neovim plugin hiding your colorcolumn when unneeded
      smartcolumn = {
        enable = true;
        setupOpts.custom_colorcolumn = {
          # this is a freeform module, it's `buftype = int;` for configuring column position
          nix = "110";
          ruby = "120";
          java = "130";
          go = [
            "90"
            "130"
          ];
        };
      };
      fastaction.enable = true; # Code actions
    };

    visuals = {
      nvim-web-devicons.enable = true;

      # Maximal
      nvim-scrollbar.enable = true;

      cellular-automaton.enable = false;
      fidget-nvim.enable = true;
      highlight-undo.enable = true;

      indent-blankline.enable = true;

      nvim-cursorline = {
        enable = true;
        setupOpts.line_timeout = 0;
      };
    };

    statusline = {
      lualine = {
        enable = true;
        #theme = "auto";
      };
    };
  };
}
