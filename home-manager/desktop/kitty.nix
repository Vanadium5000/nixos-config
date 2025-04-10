{lib, ...}: {
  programs.kitty = {
    enable = true;

    font = {
      # Fonts installed in nixos/terminal/fonts.nix
      name = "JetBrainsMono Nerd Font";
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
    };
    settings = {
      cursor_shape = "beam"; # Thin line
      cursor_blink_interval = 0; # Seconds, 0 for none
      cursor_stop_blinking_after = 0; # Seconds, 0 for none

      # When the mouse hovers over a terminal hyperlink, show the URL
      # that will be activated if clicked
      show_hyperlink_targets = "yes";

      # Ricing
      background_opacity = lib.mkForce 0.7;

      # Show a desktop notification when a long-running command finishes
      notify_on_cmd_finish = "unfocused"; # Only send when the window does not have keyboard focus

      # The shell program to execute
      shell = lib.mkOverride 40 "fish --login -C \"tmux attach -t dev || tmux new -s dev\"";
    };
  };
}
