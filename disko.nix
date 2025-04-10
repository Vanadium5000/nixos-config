{device ? throw "Set this to your disk device, e.g. /dev/sda", ...}: {
  # https://github.com/vimjoyer/impermanent-setup/blob/main/final/disko.nix
  # Partition device with:
  #
  # sudo nix --experimental-features "nix-command flakes" \
  # run github:nix-community/disko/latest -- \
  # --mode disko ./disko.nix \
  # --arg device '"/dev/..."'
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            name = "ESP";
            size = "512M";
            type = "EF00"; # EFI partition type
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";

              mountOptions = ["defaults" "umask=077"]; # "umask=077" allows read, write, and execute permission for the file's owner, but prohibits read, write, and execute permission for everyone else, improves security
            };
          };

          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "root_vg";
            };
          };
        };
      };
    };
    lvm_vg = {
      root_vg = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"]; # --force, overrides existing partition

              subvolumes = {
                "/root" = {
                  # "noatime" disables the updating of access time for both files and directories so that reading a file does not update their access time, improves performance
                  # "noexec" makes it impossible to write and run executable files outside of /nix/store, greatly increasing security
                  mountOptions = ["compress=zstd" "subvol=root" "noatime"];
                  mountpoint = "/";
                };

                "/persist" = {
                  mountOptions = ["compress=zstd" "subvol=persist" "noatime"];
                  mountpoint = "/persist";
                };

                "/nix" = {
                  mountOptions = ["compress=zstd" "subvol=nix" "noatime"];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
  };
}
