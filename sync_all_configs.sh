#!/bin/bash

# A master script to save all local dotfile configurations to the repository
# by calling the generic save script for each application.

# Ensure the script exits if any command fails
set -e

# --- Configuration ---
# The directory where your sync script is located.
SCRIPT_DIR="/home/yoshua/personal/dev"

# An array of config names to save.
CONFIGS_TO_SYNC=(
    "hypr"
    "waybar"
    "nvim"
    "kitty"
    "tmux"
    "zsh"
)
# --- End of Configuration ---

echo "🚀 Starting to save all configurations to the repository..."
echo

for config in "${CONFIGS_TO_SYNC[@]}"; do
    script_path="$SCRIPT_DIR/sync_config.sh"
    config_name="${config^}" # Capitalize first letter

    echo "--- Saving $config_name configuration ---"
    if [ -f "$script_path" ]; then
        bash "$script_path" "$config"
    else
        echo "⚠️  Warning: Script not found at '$script_path'. Skipping." >&2
    fi
done

echo "✅ All configurations saved to repository successfully."
