{ pkgs, ... }:
{
  # Note: use gitwatch (basically syncthing over git) for most stuff instead
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  environment.systemPackages = with pkgs; [ syncthing ];

  # Persist necessary config files
  # FIXME: add impermanence paths
  customPersist.home.directories = [ ];
  customPersist.nixos.directories = [ ];
}
