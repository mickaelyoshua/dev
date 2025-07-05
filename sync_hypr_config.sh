#!/bin/bash

# A script to synchronize the hypr configuration from a git repo
# to the local ~/.config/hypr directory.

# --- Configuration ---
# Source directory (your git repo)
SOURCE_DIR="/home/yoshua/personal/dev/.config/hypr"

# Destination directory (your local config)
DEST_DIR="$HOME/.config/hypr"

# Parent directory for backups
BACKUP_PARENT_DIR="$HOME/.config/hypr_backups"
# --- End of Configuration ---

# Ensure the script exits if any command fails
set -e

# 1. Check for dependencies
if ! command -v rsync &> /dev/null; then
    echo "Error: rsync is not installed. Please install it to continue." >&2
    exit 1
fi

# 2. Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory not found at '$SOURCE_DIR'" >&2
    exit 1
fi

# 3. Create a timestamped backup directory for any overwritten files
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR="$BACKUP_PARENT_DIR/$TIMESTAMP"
echo "==> Creating backup of current configuration in: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# 4. Use rsync to synchronize the directories.
#    -a: archive mode (preserves permissions, ownership, etc.)
#    -v: verbose output
#    --delete: delete files in dest that are not in source
#    --backup: creates backups of overwritten files
#    --backup-dir: specifies where to store the backups
#    --exclude='.git': prevents copying the git repository data
echo "==> Synchronizing files from '$SOURCE_DIR' to '$DEST_DIR'..."

rsync -av --delete --backup --backup-dir="$BACKUP_DIR" --exclude='.git' "$SOURCE_DIR/" "$DEST_DIR/"

echo "✅ Success! Your Hyprland configuration has been updated from the repository."
echo "A backup of the previous state was saved to '$BACKUP_DIR'."