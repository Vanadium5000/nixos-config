{ lib, ... }:
{
  boot = {
    loader = {
      # efi = {
      #   # Mounts efi partition to "/boot"
      #   efiSysMountPoint = "/boot";
      #   canTouchEfiVariables = true; # Whether the installation process is allowed to modify EFI boot variables
      # };
      # Use the systemd-boot EFI boot loader.
      # systemd-boot = {
      #   enable = true;
      #   consoleMode = "auto"; # Pick a suitable mode automatically using heuristics
      # };

      # Use the grub EFI boot loader.
      # NOTE: No need to set devices, disko will add all devices that have a EF02 partition to the list already
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = lib.mkDefault "nodev"; # For EFI, set to "nodev" as GRUB doesn't need a specific device
      };
    };

    #initrd.systemd.enable = true; # Enables systemd in initrd
  };
}
