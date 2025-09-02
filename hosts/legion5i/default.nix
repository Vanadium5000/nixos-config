{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    # Power management
    ../common/tlp.nix

    ../../nixos/desktop
    ../../nixos/terminal

    ./hardware-configuration.nix # required

    # Drivers and settings, https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    # Disko REPLACED
    # FIXME: Disko/filesystem config is ugly
    #(import ../../disko.nix {device = "/dev/nvme0n1";})
    ../../disko-replace-legion.nix
  ];

  # Set hostname to the same as the nixosConfiguration used
  var.hostname = "legion5i";

  # Keyboard
  services.xserver.xkb.layout = "gb";
  console.useXkbConfig = true;

  # Enabled by most DEs & by steam anyways
  hardware.graphics.enable = true;

  hardware.nvidia = {
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # It is suggested to use the open source kernel modules on Turing or later GPUs (RTX series, GTX 16xx)
    open = true;

    prime = {
      # Make sure to use the correct Bus ID values for your system!
      # You can find them using "sudo lshw -c display"
      intelBusId = "PCI:0:2:0"; # integrated
      nvidiaBusId = "PCI:1:0:0"; # dedicated
    };

    # Select the appropriate driver version for the GPU
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable cuda support in programs despite it being unfree
  nixpkgs.config.cudaSupport = true;

  # Add these environment variables for better CUDA support
  environment.variables = {
    # Your existing variables ...
    CUDA_PATH = "${pkgs.cudatoolkit}";
    LD_LIBRARY_PATH =
      "${pkgs.cudatoolkit}/lib:${pkgs.cudaPackages_12_3.cudnn}/lib"
      # https://github.com/anotherhadi/nixy/blob/main/home/programs/shell/zsh.nix
      + ":${config.hardware.nvidia.package}/lib:$LD_LIBRARY_PATH"; # Extra for btop nvidia support
  };

  # Brightness keys
  home-manager.users."${config.var.username}".wayland.windowManager.hyprland.settings.bindle = [
    ",XF86MonBrightnessUp, exec, brightness-up 'intel_backlight'" # Brightness Up
    ",XF86MonBrightnessDown, exec, brightness-down 'intel_backlight'" # Brightness Down
    "$shift,XF86MonBrightnessUp, exec, brightness-up-small 'intel_backlight'" # Brightness Up Small
    "$shift,XF86MonBrightnessDown, exec, brightness-down-small 'intel_backlight'" # Brightness Down Small
  ];
}
