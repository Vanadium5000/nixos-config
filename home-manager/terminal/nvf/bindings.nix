_: {
  programs.nvf.settings.vim = {
    maps = {
      normal = {
        # "\\" = {
        #   action = "<cmd>lua MiniFiles.open()<cr>";
        #   desc = "Open MiniFiles";
        # };
        "\\" = {
          action = "<cmd>Neotree<cr>";
          desc = "Open Neotree";
        };
        # ";" = {
        #   action = ":";
        #   desc = "Maps semi-colon to colon";
        # };
        "<C-s>" = {
          action = "<cmd> w <cr>";
          desc = "Maps <C-s> to save";
        };

        # Clear highlights on search when pressing <Esc> in normal mode
        # See `:help hlsearch`
        "<Esc>" = {
          action = "<cmd>nohlsearch<CR>";
        };

        # CodeCompanion - AI-powered coding, seamlessly in Neovim
        "<LocalLeader>a" = {
          action = "<cmd>CodeCompanionChat Toggle<cr>";
        };
        "<C-a>" = {
          action = "<cmd>CodeCompanionActions<cr>";
        };
      };

      insert = {
        "<C-s>" = {
          action = "<cmd> w <cr>";
          desc = "Maps <C-s> to save";
        };
      };

      visual = {
        # CodeCompanion - AI-powered coding, seamlessly in Neovim
        "ga" = {
          action = "<cmd>CodeCompanionChat Add<cr>";
        };
        "<LocalLeader>a" = {
          action = "<cmd>CodeCompanionChat Toggle<cr>";
        };
        "<C-a>" = {
          action = "<cmd>CodeCompanionActions<cr>";
        };
      };
    };
  };
}
