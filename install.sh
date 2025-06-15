#!/bin/bash

# Safety settings
set -o nounset  # Exit on undefined variable
set -o errexit  # Exit on command failure
set -o pipefail # Exit on pipeline failure

# Default configuration
DEFAULT_DEVICE="nvme0n1"

# Allow DEVICE to be specified as a command-line argument
DEVICE="${1:-$DEFAULT_BACKUP_DIR}"

# Safety check for device
if [[ -z "$DEVICE}" ]]; then
    echo "Error: No device specified and no default device set"
    exit 1
fi

if [[ ! -b "/dev/$DEVICE" ]]; then
    echo "Error: Device /dev/$DEVICE does not exist or is not a block device"
    exit 1
fi

if [[ ! -r "/dev/$DEVICE" ]] || [[ ! -w "/dev/$DEVICE" ]]; then
    echo "Error: Insufficient permissions for /dev/$DEVICE"
    exit 1
fi

# Make "boot", "swap", and "nixos" partitons by label
# Boot/EFI partition
parted "/dev/$DEVICE" -- mklabel gpt
parted "/dev/$DEVICE" -- mkpart boot fat32 1MiB 1GiB
parted "/dev/$DEVICE" -- set 1 boot on
mkfs.vfat "/dev/${DEVICE}p1"

# Swap partiton
parted "/dev/$DEVICE" -- mkpart swap linux-swap 1GiB 17iB
mkswap -L swap "/dev/${DEVICE}p2"
swapon "/dev/${DEVICE}p2"

# NixOS parition
parted "/dev/$DEVICE" -- mkpart nixos 17GiB 100%
mkfs.btrfs -L nixos "/dev/${DEVICE}p3"

mount "/dev/${DEVICE}p3" /mnt
