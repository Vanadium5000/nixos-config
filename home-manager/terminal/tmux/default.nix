{ pkgs, ... }:
{
  stylix.targets.tmux.enable = true; # Base16 theme

  programs.tmux = {
    enable = true;
    prefix = "C-a"; # Set the prefix key

    mouse = true; # Enable mouse support
    baseIndex = 1;
    clock24 = true; # Use 24 hour clock

    # Override the hjkl and HJKL bindings for pane navigation and resizing in VI mode
    customPaneNavigationAndResize = true;

    extraConfig = ''
      # Binds leader + r to reload tmux
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Enables support for image previews, etc.
      set -g allow-passthrough on

      # -- display -------------------------------------------------------------------

      set -g base-index 1           # start windows numbering at 1
      setw -g pane-base-index 1     # make pane numbering consistent with windows

      setw -g automatic-rename on   # rename window to reflect current program
      set -g renumber-windows on    # renumber windows when a window is closed

      set -g set-titles on          # set terminal title

      set -g display-panes-time 800 # slightly longer pane indicators display time
      set -g display-time 1000      # slightly longer status messages display time

      set -g status-interval 10     # redraw status line every 10 seconds

      # clear both screen and history
      bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

      # activity
      set -g monitor-activity on
      set -g visual-activity off

      # split current window horizontally
      bind _ split-window -v
      # split current window vertically
      bind | split-window -h

      # pane resizing
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2

      # set vi-mode
      set-window-option -g mode-keys vi

      # -- copy mode -----------------------------------------------------------------
      bind Enter copy-mode # enter copy mode

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel
      bind -T copy-mode-vi H send -X start-of-line
      bind -T copy-mode-vi L send -X end-of-line

      # catppuccin bar
      set -g @catppuccin_date_time "%H:%M %Y-%m-%d"
      set -gq @catppuccin_status_left_separator "█"
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""

      #set -g status-right "#{E:@catppuccin_status_application}"
      #set -ag status-right "#{E:@catppuccin_status_session}"
      #set -agF status-right "#{E:@catppuccin_status_cpu}"
      #set -agF status-right "#{E:@catppuccin_status_battery}"
      #set -ag status-right "#{E:@catppuccin_status_date_time}"
    '';

    # Run the sensible plugin at the top of the configuration
    sensibleOnTop = true;

    # Plugins
    plugins = with pkgs; [
      tmuxPlugins.sensible # Sensible defaults
      tmuxPlugins.yank
      # Navigate tmux panes & vim splits with same key bindings (CTRL-h/j/k/l)
      tmuxPlugins.vim-tmux-navigator

      # Custom packages
      battery
      cpu
      catppuccin # Soothing pastel theme for Tmux
    ];
  };
}
