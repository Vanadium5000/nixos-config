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
  ];

  # Set hostname to the same as the nixosConfiguration used
  var.hostname = "ionos_vps";

  users.users.${config.var.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFsIUmSPfK9/ncfGjINjeI7sz+QK7wyaYJZtLhVpiU66 thealfiecrawford@icloud.com"
  ];
}
