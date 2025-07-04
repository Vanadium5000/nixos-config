{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    # Navigate tmux panes & vim splits with same key bindings
    # https://github.com/christoomey/vim-tmux-navigator
    extraPlugins = with pkgs.vimPlugins; {
      vim-tmux-navigator = {
        package = vim-tmux-navigator;
      };
    };

    maps.normal = {
      # Keybinds to make vim split/tmux pane navigation easier.
      # Use CTRL+<hjkl> to switch between windows
      "<C-h>".action = "<cmd><C-U>TmuxNavigateLeft<cr>";
      "<C-j>".action = "<cmd><C-U>TmuxNavigateDown<cr>";
      "<C-k>".action = "<cmd><C-U>TmuxNavigateUp<cr>";
      "<C-l>".action = "<cmd><C-U>TmuxNavigateRight<cr>";
      "<C-\\>".action = "<cmd><C-U>TmuxNavigatePrevious<cr>";
    };
  };
}
