#!/bin/bash

# A master script to synchronize all dotfile configurations by calling
# the generic sync script for each application.

# Ensure the script exits if any command fails
set -e

# --- Configuration ---
# The directory where your sync script is located.
SCRIPT_DIR="/home/yoshua/personal/dev"

# An array of config names to sync.
CONFIGS_TO_SYNC=(
    "hypr"
    "waybar"
    "nvim"
    "kitty"
)
# --- End of Configuration ---

echo "🚀 Starting full configuration sync..."
echo

for config in "${CONFIGS_TO_SYNC[@]}"; do
    script_path="$SCRIPT_DIR/sync_config.sh"
    config_name="${config^}" # Capitalize first letter

    echo "--- Syncing $config_name ---"
    if [ -f "$script_path" ]; then
        bash "$script_path" "$config"
    else
        echo "⚠️  Warning: Script not found at '$script_path'. Skipping." >&2
    fi
done

echo "✅ All configurations synchronized successfully."