_: {
  # Enable Docker virtualisation
  virtualisation.docker = {
    enable = true;

    # Needed if usings a btrfs filesystem
    storageDriver = "btrfs";
  };
}
