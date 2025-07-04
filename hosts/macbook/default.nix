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
    inputs.nixos-hardware.nixosModules.apple-t2
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    # Disko
    ../../disko-replace-mac.nix
  ];

  # Set hostname to the same as the nixosConfiguration used
  var.hostname = "macbook";

  # Enable s2idle sleep, disable broken s3 sleep
  # systemd.sleep.extraConfig = ''
  #   SuspendState=mem
  #   MemorySleepMode=s2idle
  # '';

  # Workaround for suspend/resume issues on T2 Macs
  systemd.services."suspend-fix-t2" = {
    enable = true;
    unitConfig = {
      Description = "Disable and Re-Enable Apple BCE Module (and Wi-Fi)";
      Before = "sleep.target";
      StopWhenUnneeded = "yes";
    };
    serviceConfig = {
      User = "root";
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = [
        "/run/current-system/sw/bin/modprobe -r brcmfmac_wcc"
        "/run/current-system/sw/bin/modprobe -r brcmfmac"
        "/run/current-system/sw/bin/rmmod -f apple-bce"
      ];
      ExecStop = [
        "/run/current-system/sw/bin/modprobe apple-bce"
        "/run/current-system/sw/bin/modprobe brcmfmac"
        "/run/current-system/sw/bin/modprobe brcmfmac_wcc"
      ];
    };
    wantedBy = [ "sleep.target" ];
  };

  # Keyboard
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.variant = ""; # mac
  console.useXkbConfig = true;

  # Enabled by most DEs & by steam anyways
  hardware.graphics.enable = true;

  # Make audio sound better
  services.pipewire = {
    extraConfig = {
      pipewire-pulse."92-fix-crackle" = {
        "pulse.properties" = {
          "pulse.properties" = {
            "pulse.min.req" = "1024/48000";
            "pulse.default.req" = "1024/48000";
            "pulse.max.req" = "1024/48000";
            "pulse.min.quantum" = "1024/48000";
            "pulse.max.quantum" = "1024/48000";
          };
          "stream.properties" = {
            "node.latency" = "1024/48000";
            "resample.quality" = 1;
          };
        };
      };
      pipewire."92-fix-crackle" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 1024;
          "default.clock.max-quantum" = 1024;
        };
      };
    };
  };

  # Switch cmd with option, and fn with ctrl: for a more normal keyboard layout
  # home-manager.users.${config.var.username} = {
  #   wayland.windowManager.hyprland.settings.input.kb_options = "super:swapalt,function:swapctrl";
  # };

  # Swap fn & ctrl, opt & cmd
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=1 swap_fn_leftctrl=1 swap_opt_cmd=1
  '';

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

  # Brightness keys
  home-manager.users."${config.var.username}".wayland.windowManager.hyprland.settings.bindle = [
    ",XF86KbdBrightnessUp, exec, brightness-up 'apple::kbd_backlight'" # Kbd Brightness Up
    ",XF86KbdBrightnessDown, exec, brightness-down 'apple::kbd_backlight'" # Kbd Brightness Down
    "$shift,XF86KbdBrightnessUp, exec, brightness-up-small 'apple::kbd_backlight'" # Kbd Brightness Up Small
    "$shift,XF86KbdBrightnessDown, exec, brightness-down-small 'apple::kbd_backlight'" # Kbd Brightness Down Small
  ];
}
