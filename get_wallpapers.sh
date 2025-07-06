#!/bin/bash

# A script to download a list of wallpapers.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# The directory to save the wallpapers in.
# Note: The tilde (~) is expanded by the shell, so we use $HOME for portability.
DEST_DIR="$HOME/personal/wallpapers"

# An array of wallpaper URLs to download.
WALLPAPER_URLS=(
    "https://images4.alphacoders.com/132/thumb-440-1323467.webp"
    "https://images5.alphacoders.com/133/thumb-440-1333027.webp"
    "https://images.alphacoders.com/727/thumb-440-727125.webp"
)
# --- End of Configuration ---

# 1. Check for dependencies
if ! command -v wget &> /dev/null; then
    echo "Error: wget is not installed. Please install it to continue." >&2
    exit 1
fi

# 2. Create destination directory if it doesn't exist
echo "==> Ensuring destination directory exists: $DEST_DIR"
mkdir -p "$DEST_DIR"

# 3. Download the wallpapers
echo "🚀 Starting wallpaper download..."
for url in "${WALLPAPER_URLS[@]}"; do
    echo "--> Downloading from $url"
    # Use wget to download the file into the destination directory.
    # -P specifies the destination directory.
    # -nc (no-clobber) prevents re-downloading files that already exist.
    wget -nc -P "$DEST_DIR" "$url"
done

echo
echo "✅ All wallpapers downloaded successfully to $DEST_DIR."
