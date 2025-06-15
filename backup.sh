#!/bin/bash

# Safety settings
set -o nounset  # Exit on undefined variable
set -o errexit  # Exit on command failure
set -o pipefail # Exit on pipeline failure

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

# Function to check if command exists
check_command() {
        if ! command -v "$1" >/dev/null 2>&1; then
                echo "Error: Required command '$1' not found."
                exit 1
        fi
}

# Check for required commands
check_command btrfs
check_command date
check_command find

# Verify Btrfs properties
is_btrfs_subvolume "$SOURCE_SUBVOL"
is_btrfs_subvolume "$SNAPSHOT_DIR"
is_btrfs_filesystem_or_subvolume "$BACKUP_DIR"

# Find the most recent snapshot
LAST_SNAPSHOT=$(find "$SNAPSHOT_DIR" -maxdepth 1 -name "persist_*" -type d | sort -r | head -n 1)

# Create new snapshot
echo "Creating snapshot: persist_$TIMESTAMP"
if ! sudo btrfs subvolume snapshot -r "$SOURCE_SUBVOL" "$SNAPSHOT_DIR/persist_$TIMESTAMP"; then
        echo "Error: Failed to create snapshot."
        exit 1
fi

# Send snapshot to backup directory
if [ -z "$LAST_SNAPSHOT" ]; then
        echo "Performing initial backup..."
        if ! sudo btrfs send "$SNAPSHOT_DIR/persist_$TIMESTAMP" | sudo btrfs receive "$BACKUP_DIR"; then
                echo "Error: Initial backup failed."
                # Clean up failed snapshot
                sudo btrfs subvolume delete "$SNAPSHOT_DIR/persist_$TIMESTAMP" 2>/dev/null || true
                exit 1
        fi
else
        echo "Performing incremental backup using parent: $LAST_SNAPSHOT..."
        if ! sudo btrfs send -p "$LAST_SNAPSHOT" "$SNAPSHOT_DIR/persist_$TIMESTAMP" | sudo btrfs receive "$BACKUP_DIR"; then
                echo "Error: Incremental backup failed."
                # Clean up failed snapshot
                sudo btrfs subvolume delete "$SNAPSHOT_DIR/persist_$TIMESTAMP" 2>/dev/null || true
                exit 1
        fi
fi

# Clean up old snapshots (keep last 7 days)
echo "Cleaning up snapshots older than 7 days..."
find "$SNAPSHOT_DIR" -maxdepth 1 -name "persist_*" -type d -mtime +7 -exec sudo btrfs subvolume delete {} \; 2>/dev/null || true
find "$BACKUP_DIR" -maxdepth 1 -name "persist_*" -type d -mtime +7 -exec sudo btrfs subvolume delete {} \; 2>/dev/null || true

echo "Backup completed successfully: persist_$TIMESTAMP"
