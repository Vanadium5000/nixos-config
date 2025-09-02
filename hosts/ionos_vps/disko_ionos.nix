{
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
}:
{
  # Partition device with:
  #
  # sudo nix --experimental-features "nix-command flakes" \
  # run github:nix-community/disko/latest -- \
  # --mode disko ./disko.nix \
  # --arg device '"/dev/..."'
  disko.devices = {
    disk = {
      main = {
        inherit device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              priority = 1;
              name = "boot";
              start = "1M";
              end = "128M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "/root" = {
                    mountOptions = [
                      "compress=zstd"
                    ];
                    mountpoint = "/";
                  };

                  # Parent is not mounted so the mountpoint must be set
                  "/persist" = {
                    mountOptions = [
                      "compress=zstd"
                    ];
                    mountpoint = "/persist";
                  };

                  # Parent is not mounted so the mountpoint must be set
                  "/old_roots" = {
                    mountOptions = [
                      "compress=zstd"
                    ];
                    mountpoint = "/old_roots";
                  };

                  # Parent is not mounted so the mountpoint must be set
                  # "noatime" disables the updating of access time for both files and directories
                  # so that reading a file does not update their access time, improves performance
                  "/nix" = {
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };

                  # Subvolume for the swapfile
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap = {
                      swapfile.size = "20M";
                      swapfile2.size = "20M";
                      swapfile2.path = "rel-path";
                    };
                  };
                };

                mountpoint = "/partition-root";
                swap = {
                  swapfile = {
                    size = "20M";
                  };
                  swapfile1 = {
                    size = "20M";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
