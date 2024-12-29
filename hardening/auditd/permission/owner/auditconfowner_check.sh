#!/bin/bash

# Find files under /etc/audit/ that are not owned by the 'root' user
output=$(find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root)

# Check if there is any output from the find command
if [ -z "$output" ]; then
    echo "PASSED!! No files are found with incorrect ownership."
else
    echo "FAILED!! The following files need to be remediated:"
    echo "$output"
fi

