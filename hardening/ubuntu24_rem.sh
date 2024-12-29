#!/bin/bash

BASE_DIR="/hardening"

# Ensure the script is not running multiple times
LOCK_FILE="/tmp/ubuntu_24_rem.lock"

# Check if the script is already running
if [ -f "$LOCK_FILE" ]; then
    echo "The remove script is already running. Exiting..."
    exit 1
fi

# Create a lock file to prevent multiple executions
touch "$LOCK_FILE"

# Function to run all *_rem.sh files
run_rem_files() {
    # Find all *_rem.sh files and execute them one by one
    find $BASE_DIR -type f -name '*_rem.sh' | sort | while read file; do
        echo "Running $file..."
        bash "$file"
        sleep 3  # Wait for 3 seconds after executing each file
    done
}

run_rem_files

rm -f "$LOCK_FILE"

