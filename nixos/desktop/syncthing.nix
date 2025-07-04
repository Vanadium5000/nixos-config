{ pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  environment.systemPackages = with pkgs; [ syncthing ];
}
