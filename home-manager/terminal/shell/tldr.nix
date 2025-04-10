_: {
  # Tealdeer - Very fast implementation of tldr written in Rust
  programs.tealdeer = {
    enable = true;

    settings = {
      display = {
        compact = true; # Empty lines are stripped out
        use_pager = false;
      };
      updates = {
        auto_update = true; # Avoid manually updating every reboot
      };
    };
  };
}
