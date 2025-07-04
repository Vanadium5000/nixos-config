_: {
  # Direnv augments existing shells with a new feature that can load and unload environment variables depending on the current directory
  programs.direnv = {
    enable = true;
    #silent = true;
    nix-direnv.enable = true;
  };

  # Save direnv stuff
  customPersist.home.directories = [ ".local/share/direnv" ];
}
