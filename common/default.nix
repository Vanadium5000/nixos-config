{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./impermanence.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./ssh.nix
    ./users.nix

    ../config # Variables/settings
    ../config/theme.nix # Theme settings (only needed for home-manager)
  ];

  # Locales
  time.timeZone = config.var.timeZone;
  i18n.defaultLocale = config.var.locale;

  # Disables default packages such as perl
  environment.defaultPackages = [ ];

  # Use latest available linux kernel
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  home-manager = {
    # Instead use the global pkgs that is configured via the system level nixpkgs options
    useGlobalPkgs = true;
    # Install packages to /etc/profiles instead of $HOME/.nix-profile
    useUserPackages = true;
    # If existing files are in the way, backup & overwrite them
    backupFileExtension = ".bak";
  };

  # Whether to enable firmware with a license allowing redistribution
  hardware.enableRedistributableFirmware = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions
  system.stateVersion = "24.05";
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
}
