{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    ../../nixos/terminal

    # Disko
    inputs.disko.nixosModules.disko
    (import ./disko_ionos.nix { device = "/dev/vda"; })
    ./hardware-configuration.nix

    # Services to run My Website
    ./my-website.nix
  ];

  # Set hostname to the same as the nixosConfiguration used
  var.hostname = "ionosvps";

  users.users.${config.var.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFsIUmSPfK9/ncfGjINjeI7sz+QK7wyaYJZtLhVpiU66 thealfiecrawford@icloud.com"
  ];

  # Reduce ram usage
  max-jobs = "1"; # Use only 1 core for building - default is 1, int or "auto"
  cores = 1; # Use only 1 per build job
  # Reduce binary cache ram usage
  http-connections = 8; # Max number of parallel TCP connections - default is 25
  max-substitution-jobs = 4; # Max number of substitution jobs in parallel - default is 16
}
