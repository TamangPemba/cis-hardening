#!/bin/bash
BASE_DIR="/hardening"

LOCK_FILE="/tmp/ubuntu_24_check.lock"

# Check if the script is already running
if [ -f "$LOCK_FILE" ]; then
    echo "The check script is already running. Exiting..."
    exit 1
fi

# Create a lock file to prevent multiple executions
touch "$LOCK_FILE"

# Function to run all *_check.sh files
run_check_files() {
    # Find all *_check.sh files and execute them one by one
    find $BASE_DIR -type f -name '*_check.sh' | sort | while read file; do
        echo "Running $file..."
        bash "$file"
        sleep 3  # Wait for 3 seconds after executing each file
    done
}

run_check_files

rm -f "$LOCK_FILE"

