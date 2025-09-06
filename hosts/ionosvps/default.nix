{
  inputs,
  config,
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
}
