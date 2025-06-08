#!/bin/bash

# Safety
set -o nounset # Exits if an undefined variable is referenced
#set -o errexit  # Exits if any command exits with a non-zero status (fails)
set -o pipefail # Exits if any command in a pipeline fails

# Default configuration
SOURCE_SUBVOL="/persist"
SNAPSHOT_DIR="/snapshots"
DEFAULT_BACKUP_DIR="/mnt/external/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Allow BACKUP_DIR to be specified as a command-line argument
BACKUP_DIR="${1:-$DEFAULT_BACKUP_DIR}"

# Function to check if a path is a Btrfs subvolume
is_btrfs_subvolume() {
        local path="$1"
        if ! sudo btrfs subvolume show "$path" >/dev/null 2>&1; then
                echo "Error: $path is not a Btrfs subvolume."
                exit 1
        fi
}

# Function to check if a path is a Btrfs filesystem or subvolume
is_btrfs_filesystem_or_subvolume() {
        local path="$1"
        if ! sudo btrfs subvolume show "$path" >/dev/null 2>&1 && ! sudo btrfs filesystem show "$path" >/dev/null 2>&1; then
                echo "Error: $path is not a Btrfs filesystem or subvolume."
                exit 1
        fi
}

# Verify directories exist
if [ ! -d "$SOURCE_SUBVOL" ]; then
        echo "Error: Source subvolume $SOURCE_SUBVOL does not exist."
        exit 1
fi
if [ ! -d "$SNAPSHOT_DIR" ]; then
        echo "Error: Snapshot directory $SNAPSHOT_DIR does not exist."
        exit 1
fi
if [ ! -d "$BACKUP_DIR" ]; then
        echo "Error: Backup directory $BACKUP_DIR does not exist."
        exit 1
fi

# Verify Btrfs properties
is_btrfs_subvolume "$SOURCE_SUBVOL"
is_btrfs_subvolume "$SNAPSHOT_DIR"
is_btrfs_filesystem_or_subvolume "$BACKUP_DIR"

# Find the most recent snapshot
LAST_SNAPSHOT=$(ls -t "$SNAPSHOT_DIR"/persist_* 2>/dev/null | head -n 1)

# Create new snapshot
if ! sudo btrfs subvolume snapshot -r "$SOURCE_SUBVOL" "$SNAPSHOT_DIR/persist_$TIMESTAMP"; then
        echo "Error: Failed to create snapshot."
        exit 1
fi

# Send snapshot to backup directory
if [ -z "$LAST_SNAPSHOT" ]; then
        # Initial backup
        if ! sudo btrfs send "$SNAPSHOT_DIR/persist_$TIMESTAMP" | sudo btrfs receive "$BACKUP_DIR"; then
                echo "Error: Initial backup failed."
                exit 1
        fi
else
        # Incremental backup
        if ! sudo btrfs send -p "$LAST_SNAPSHOT" "$SNAPSHOT_DIR/persist_$TIMESTAMP" | sudo btrfs receive "$BACKUP_DIR"; then
                echo "Error: Incremental backup failed."
                exit 1
        fi
fi

# Clean up old snapshots (keep last 7 days)
find "$SNAPSHOT_DIR" -name "persist_*" -mtime +7 -exec sudo btrfs subvolume delete {} \; 2>/dev/null
find "$BACKUP_DIR" -name "persist_*" -mtime +7 -exec sudo btrfs subvolume delete {} \; 2>/dev/null

echo "Backup completed successfully: persist_$TIMESTAMP"
