#!/bin/bash

# A master script to synchronize all dotfile configurations by calling
# the individual sync scripts for each application.

# Ensure the script exits if any command fails
set -e

# --- Configuration ---
# The directory where your sync scripts are located.
SCRIPT_DIR="/home/yoshua/personal/dev"

# An array of scripts to run.
SYNC_SCRIPTS=(
    "sync_hypr_config.sh"
    "sync_waybar_config.sh"
)
# --- End of Configuration ---

echo "🚀 Starting full configuration sync..."
echo

for script in "${SYNC_SCRIPTS[@]}"; do
    script_path="$SCRIPT_DIR/$script"
    config_name=$(echo "$script" | sed -e 's/sync_//' -e 's/_config.sh//' | awk '{print toupper(substr($0,1,1))substr($0,2)}')

    echo "--- Syncing $config_name ---"
    if [ -f "$script_path" ] && [ -x "$script_path" ]; then
        "$script_path"
    else
        echo "⚠️  Warning: Script not found or not executable at '$script_path'. Skipping." >&2
    fi
    echo "------------------------"
    echo
done

echo "✅ All configurations synchronized successfully."