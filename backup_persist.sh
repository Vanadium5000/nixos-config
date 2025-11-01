#!/usr/bin/env bash

# Backup script using BTRFS snapshots for /persist
# Sends snapshots to external device at /backups/$HOSTNAME
# The mount of the external device is passable with "-m ..."

# Exit on errors
set -e

# Default backup mount point
BACKUP_MOUNT="/mnt/backup"

# Check for command-line argument to override BACKUP_MOUNT
while getopts "m:" opt; do
        case $opt in
        m)
                BACKUP_MOUNT="$OPTARG"
                ;;
        \?)
                echo "Invalid option: -$OPTARG" >&2
                exit 1
                ;;
        :)
                echo "Option -$OPTARG requires an argument." >&2
                exit 1
                ;;
        esac
done

# Variables
SOURCE_DIR="/persist"
BACKUP_DIR="${BACKUP_MOUNT}/backups/$(hostname)"
SNAPSHOT_DIR="/persist/.snapshots"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SNAPSHOT_NAME="backup_${TIMESTAMP}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Error: This script must be run as root${NC}"
        exit 1
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
        echo -e "${RED}Error: Source directory $SOURCE_DIR does not exist${NC}"
        exit 1
fi

# Check if BTRFS is used for source
if ! mount | grep "$SOURCE_DIR" | grep -q btrfs; then
        echo -e "${RED}Error: $SOURCE_DIR is not on a BTRFS filesystem${NC}"
        exit 1
fi

# Check if backup mount point exists
if [ ! -d "$BACKUP_MOUNT" ]; then
        echo -e "${RED}Error: Backup mount point $BACKUP_MOUNT does not exist${NC}"
        exit 1
fi

# Check if external device is mounted
# if ! mount | grep -q "$BACKUP_MOUNT"; then
#     echo -e "${RED}Error: No device mounted at $BACKUP_MOUNT${NC}"
#     exit 1
# fi

# Check if backup device uses BTRFS
if ! mount | grep "$BACKUP_MOUNT" | grep -q btrfs; then
        echo -e "${RED}Error: Backup device at $BACKUP_MOUNT is not BTRFS${NC}"
        exit 1
fi

# Create snapshot directory if it doesn't exist
mkdir -p "$SNAPSHOT_DIR"

# Create snapshot
echo "Creating snapshot: ${SNAPSHOT_DIR}/${SNAPSHOT_NAME}"
btrfs subvolume snapshot -r "$SOURCE_DIR" "${SNAPSHOT_DIR}/${SNAPSHOT_NAME}"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Send snapshot to backup location
echo "Sending snapshot to ${BACKUP_DIR}/${SNAPSHOT_NAME}"
btrfs send "${SNAPSHOT_DIR}/${SNAPSHOT_NAME}" | btrfs receive "$BACKUP_DIR/"

# Clean up old snapshots (keep last 5)
echo "Cleaning up old snapshots..."
cd "$SNAPSHOT_DIR"
ls -d backup_* | sort -r | tail -n +6 | xargs -I {} btrfs subvolume delete {}
cd "$BACKUP_DIR"
ls -d backup_* | sort -r | tail -n +6 | xargs -I {} btrfs subvolume delete {}

echo -e "${GREEN}Backup completed successfully${NC}"

