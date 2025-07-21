#!/bin/bash

# A script to copy a local configuration to the dotfiles repository.

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

# Special case for .zshrc
if [ "$APP_NAME" = "zsh" ]; then
    SOURCE_FILE="$HOME/.zshrc"
    DEST_FILE="/home/yoshua/personal/dev/.zshrc"

    # Check if source file exists
    if [ ! -f "$SOURCE_FILE" ]; then
        echo "Error: Source file not found at '$SOURCE_FILE'" >&2
        exit 1
    fi

    echo "==> Copying '$SOURCE_FILE' to '$DEST_FILE'..."
    rsync -av "$SOURCE_FILE" "$DEST_FILE"
    echo "✅ Success! Your Zsh configuration has been saved to the repository."
    echo "✅ Done."
    exit 0
fi

# --- Configuration ---
# The local config directory to copy from.
SOURCE_DIR="$HOME/.config/$APP_NAME"
# The destination directory in the dotfiles repo.
DEST_DIR="/home/yoshua/personal/dev/.config/$APP_NAME"
# --- End of Configuration ---

# 1. Check for dependencies
if ! command -v rsync &> /dev/null; then
	echo "Error: rsync is not installed. Please install it to continue." >&2
	exit 1
fi

# 2. Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
	echo "Error: Source directory not found at '$SOURCE_DIR'" >&2
	echo "This script expects the local configuration to exist." >&2
	exit 1
fi

# 3. Ensure destination parent directory exists
mkdir -p "$(dirname "$DEST_DIR")"

# 4. Use rsync to synchronize the directories.
echo "==> Copying files from '$SOURCE_DIR' to '$DEST_DIR'..."
rsync -av --delete --exclude='.git' "$SOURCE_DIR/" "$DEST_DIR/"

DISPLAY_NAME="${APP_NAME^}" # Capitalize first letter
echo "✅ Success! Your $DISPLAY_NAME configuration has been saved to the repository."
echo "✅ Done."