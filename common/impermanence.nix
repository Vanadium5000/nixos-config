{
  lib,
  config,
  ...
}: {
  fileSystems."/persist".neededForBoot = true; # Needed for boot
  programs.fuse.userAllowOther = true; # Needed for home-manager impermanence module

  environment.persistence."/persist/system" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories =
      [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ]
      ++ config.customPersist.nixos.directories;
    files =
      [
        "/etc/machine-id"
        {
          file = "/var/keys/secret_file";
          parentDirectory = {
            mode = "u=rwx,g=,o=";
          };
        }
      ]
      ++ config.customPersist.nixos.files;
    users.${config.var.username} = {
      directories =
        [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "VirtualBox VMs"
          "Vault"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = ".nixops";
            mode = "0700";
          }
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
          #".local/share/direnv"
          ".local/share/password-store" # Passwords
        ]
        ++ config.customPersist.home.directories
        ++ config.home-manager.users."${config.var.username}".customPersist.home.directories;
      files =
        [
          ".screenrc"
        ]
        ++ config.customPersist.home.files
        ++ config.home-manager.users."${config.var.username}".customPersist.home.files;
    };
  };

  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/disk/by-label/nixos /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
}
