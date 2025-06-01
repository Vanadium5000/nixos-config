{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Power management
    ../common/tlp.nix

    ../../nixos/desktop
    ../../nixos/terminal

    ./hardware-configuration.nix # required

    # Drivers and settings, https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.apple-t2
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    # Disko
    ../../disko-replace-mac.nix  ];

  # Set hostname to the same as the nixosConfiguration used
  var.hostname = "macbook";

  # Enable s2idle sleep, disable broken s3 sleep
  systemd.sleep.extraConfig = ''
    SuspendState=mem
    MemorySleepMode=s2idle
  '';

  # Keyboard
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.variant = ""; # mac
  console.useXkbConfig = true;

  # Enabled by most DEs & by steam anyways
  hardware.graphics.enable = true;

  # Macbook T2 wifi firmware https://wiki.t2linux.org/distributions/nixos/installation/#__tabbed_7_2
  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation (final: {
      name = "brcm-firmware";
      src = ./firmware.tar;

      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        tar -xf ${final.src} -C $out/lib/firmware/brcm
      '';
    }))
  ];
}
