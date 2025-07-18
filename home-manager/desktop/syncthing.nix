{ pkgs, ... }:
{
  # Note: use gitwatch (basically syncthing over git) for most stuff instead
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  home.packages = with pkgs; [ syncthing ];

  # Persist necessary config files
  # FIXME: add impermanence paths
  customPersist.home.directories = [
    "Shared" # Shared directory
    ".local/state/syncthing" # Syncthing state/config
  ];

  customPersist.home.files = [
    ".config/syncthingtray.ini" # Syncthing tray config
  ];
}
