{ ... }:
{
  fileSystems = {
    "/" = {
      autoFormat = false;
      autoResize = false;
      depends = [ ];
      device = "/dev/disk/by-label/nixos";
      enable = true;
      encrypted = {
        blkDev = null;
        enable = false;
        keyFile = null;
        label = null;
      };
      formatOptions = null;
      fsType = "btrfs";
      label = null;
      mountPoint = "/";
      neededForBoot = false;
      noCheck = false;
      options = [
        "x-initrd.mount"
        "compress=zstd"
        "subvol=root"
        "noatime"
        "subvol=/root"
      ];
      overlay = {
        lowerdir = null;
        upperdir = null;
        useStage1BaseDirectories = true;
        workdir = null;
      };
      stratis = {
        poolUuid = null;
      };
    };
    "/boot" = {
      autoFormat = false;
      autoResize = false;
      depends = [ ];
      device = "/dev/disk/by-label/boot";
      enable = true;
      encrypted = {
        blkDev = null;
        enable = false;
        keyFile = null;
        label = null;
      };
      formatOptions = null;
      fsType = "vfat";
      label = null;
      mountPoint = "/boot";
      neededForBoot = false;
      noCheck = false;
      options = [
        "defaults"
        "umask=077"
      ];
      overlay = {
        lowerdir = null;
        upperdir = null;
        useStage1BaseDirectories = true;
        workdir = null;
      };
      stratis = {
        poolUuid = null;
      };
    };
    "/nix" = {
      autoFormat = false;
      autoResize = false;
      depends = [ ];
      device = "/dev/disk/by-label/nixos";
      enable = true;
      encrypted = {
        blkDev = null;
        enable = false;
        keyFile = null;
        label = null;
      };
      formatOptions = null;
      fsType = "btrfs";
      label = null;
      mountPoint = "/nix";
      neededForBoot = false;
      noCheck = false;
      options = [
        "x-initrd.mount"
        "compress=zstd"
        "subvol=nix"
        "noatime"
        "subvol=/nix"
      ];
      overlay = {
        lowerdir = null;
        upperdir = null;
        useStage1BaseDirectories = true;
        workdir = null;
      };
      stratis = {
        poolUuid = null;
      };
    };
    "/old_roots" = {
      autoFormat = false;
      autoResize = false;
      depends = [ ];
      device = "/dev/disk/by-label/nixos";
      enable = true;
      encrypted = {
        blkDev = null;
        enable = false;
        keyFile = null;
        label = null;
      };
      formatOptions = null;
      fsType = "btrfs";
      label = null;
      mountPoint = "/old_roots";
      neededForBoot = false;
      noCheck = false;
      options = [
        "x-initrd.mount"
        "compress=zstd"
        "subvol=old_roots"
        "noatime"
        "subvol=/old_roots"
      ];
      overlay = {
        lowerdir = null;
        upperdir = null;
        useStage1BaseDirectories = true;
        workdir = null;
      };
      stratis = {
        poolUuid = null;
      };
    };
    "/persist" = {
      autoFormat = false;
      autoResize = false;
      depends = [ ];
      device = "/dev/disk/by-label/nixos";
      enable = true;
      encrypted = {
        blkDev = null;
        enable = false;
        keyFile = null;
        label = null;
      };
      formatOptions = null;
      fsType = "btrfs";
      label = null;
      mountPoint = "/persist";
      neededForBoot = true;
      noCheck = false;
      options = [
        "x-initrd.mount"
        "compress=zstd"
        "subvol=persist"
        "noatime"
        "subvol=/persist"
      ];
      overlay = {
        lowerdir = null;
        upperdir = null;
        useStage1BaseDirectories = true;
        workdir = null;
      };
      stratis = {
        poolUuid = null;
      };
    };
  };
}
