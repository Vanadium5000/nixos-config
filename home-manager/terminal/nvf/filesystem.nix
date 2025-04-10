_: {
  programs.nvf.settings.vim = {
    # https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
    mini.files = {
      enable = false;

      setupOpts = {
        mapping = {
          close = "\\";
        };
      };
    };

    filetree = {
      neo-tree = {
        enable = true;

        setupOpts = {
          # Plugin options
          close_if_last_window = true; # Close Neo-tree if it is the last window left in the tab
          enable_cursor_hijack = true;
          enable_git_status = true;
          enable_diagnostics = true;

          default_component_configs = {
            indent = {
              with_expanders = true;
              expander_collapsed = "";
              expander_expanded = "";
              expander_highlight = "NeoTreeExpander";
            };
          };

          filesystem = {
            filtered_items = {
              visible = false; # when true, they will just be displayed differently than normal items
              hide_dotfiles = false;
              hide_gitignored = true;
              hide_hidden = false;
              hide_by_name = [
                ".DS_Store"
                "thumbs.db"
                "node_modules"
                ".git"
              ];
            };

            follow_current_file = {
              enabled = true; # This will find and focus the file in the active buffer every time
              # the current file is changed while the tree is open.
              leave_dirs_open = false; # `false` closes auto expanded dirs, such as with `:Neotree reveal`
            };

            window = {
              mappings = {
                "\\" = "close_window";
              };
            };
          };
        };
      };
      nvimTree = {
        enable = false;

        mappings = {
          focus = "\\";
          toggle = "|";
        };
      };
    };
  };
}
