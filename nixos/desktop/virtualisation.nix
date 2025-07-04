{
  pkgs,
  lib,
  ...
}:
{
  programs.virt-manager.enable = true;

  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;

      networkSocket.openFirewall = true;
    };

    libvirtd.enable = true;
    oci-containers.backend = "podman";
  };

  # Add 'newuidmap' and 'sh' to the PATH for users' Systemd units.
  # Required for Rootless podman.
  # https://discourse.nixos.org/t/rootless-podman-setup-with-home-manager/57905
  #systemd.user.extraConfig = ''
  #  DefaultEnvironment="PATH=/run/current-system/sw/bin:/run/wrappers/bin:${lib.makeBinPath [pkgs.bash]}"
  #'';

  environment.systemPackages = with pkgs; [
    pods # frontend for podman

    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-compose # start group of containers for dev
  ];

  virtualisation.waydroid.enable = true;
}
