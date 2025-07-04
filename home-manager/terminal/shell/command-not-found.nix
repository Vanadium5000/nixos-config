_: {
  # Requires channels
  programs.command-not-found.enable = false;

  # command-not-found alternative
  programs.nix-index = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  # Persist nix-index cache, which takes a long time to make
  customPersist.home.directories = [ ".cache/nix-index" ];
}
