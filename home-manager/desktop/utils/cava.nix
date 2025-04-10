_: {
  # Cross-platform Audio Visualizer
  programs.cava = {
    enable = true;

    settings = {
      general.framerate = 60; # Default
      input.method = "pipewire"; # Default

      #color.gradient = 1; # Enable gradient mode - broken
    };
  };
}
