_: {
  boot = {
    loader = {
      efi = {
        # Mounts efi partition to "/boot"
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true; # Whether the installation process is allowed to modify EFI boot variables
      };
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        consoleMode = "auto"; # Pick a suitable mode automatically using heuristics
      };
    };

    #initrd.systemd.enable = true; # Enables systemd in initrd
  };
}
