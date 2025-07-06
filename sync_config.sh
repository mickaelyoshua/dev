#!/bin/bash

# A generic script to synchronize a configuration from a git repo
# to the local ~/.config/<app> directory.

# Ensure the script exits if any command fails
set -e

# --- Validation ---
if [ -z "$1" ]; then
    echo "Error: Application name not provided." >&2
    echo "Usage: $0 <app_name>" >&2
    echo "Example: $0 nvim" >&2
    exit 1
fi

APP_NAME="$1"

# --- Configuration ---
SOURCE_DIR="/home/yoshua/personal/dev/.config/$APP_NAME"
DEST_DIR="$HOME/.config/$APP_NAME"
BACKUP_PARENT_DIR="$HOME/.config/${APP_NAME}_backups"
# --- End of Configuration ---

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

# 3. Create a timestamped backup directory
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR="$BACKUP_PARENT_DIR/$TIMESTAMP"
echo "==> Creating backup of current configuration in: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# 4. Use rsync to synchronize the directories.
echo "==> Synchronizing files from '$SOURCE_DIR' to '$DEST_DIR'..."
rsync -av --delete --backup --backup-dir="$BACKUP_DIR" --exclude='.git' "$SOURCE_DIR/" "$DEST_DIR/"

DISPLAY_NAME="${APP_NAME^}" # Capitalize first letter
echo "✅ Success! Your $DISPLAY_NAME configuration has been updated from the repository."
echo "A backup of the previous state was saved to '$BACKUP_DIR'."

# 5. Reload application if applicable
case "$APP_NAME" in
    waybar)
        if pgrep -x "waybar" > /dev/null; then
            echo "==> Restarting Waybar..."
            killall waybar
            # Wait for the process to terminate to avoid race conditions
            while pgrep -x "waybar" > /dev/null; do sleep 0.1; done
            waybar &> /dev/null &
        fi
        ;;
    hypr)
        echo "==> Reloading Hyprland..."
        hyprctl reload
        ;;
esac

echo "✅ Done."