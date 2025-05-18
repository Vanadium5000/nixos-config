{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default

    # Stylix support
    #./base16.nix

    ./bindings.nix
    ./cmp.nix
    ./code-companion.nix # AI
    ./filesystem.nix
    ./lsp.nix
    ./telescope.nix
    ./tmux.nix
    ./treesitter.nix
    ./ui.nix
    ./utilities.nix
  ];

  home.packages = [pkgs.ueberzugpp]; # For image support

  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings.vim = {
      viAlias = true;
      vimAlias = true;

      globals.mapleader = " "; # The leader key used for <leader> mappings
      clipboard.enable = true;

      debugMode = {
        enable = false;
        level = 16;
        logFile = "/tmp/nvim.log";
      };

      spellcheck = {
        enable = true;
        languages = ["en" "en_gb" "en_us"];

        programmingWordlist.enable = true;
      };

      autopairs.nvim-autopairs.enable = true;

      tabline = {
        nvimBufferline.enable = true;
      };

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };

      minimap = {
        minimap-vim.enable = false;

        # Maximal
        codewindow.enable = true; # lighter, faster, and uses lua for configuration
      };

      dashboard = {
        dashboard-nvim.enable = false;

        # Maximal
        alpha.enable = false;
      };

      notify = {
        nvim-notify.enable = true; # notification ui
      };

      projects = {
        # Maximal
        project-nvim.enable = true;
      };

      notes = {
        obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
        orgmode.enable = false;

        todo-comments.enable = true;
      };

      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };

      session = {
        nvim-session-manager.enable = false;
      };

      gestures = {
        gesture-nvim.enable = false;
      };

      comments = {
        comment-nvim.enable = true;
      };
    };
  };
}
