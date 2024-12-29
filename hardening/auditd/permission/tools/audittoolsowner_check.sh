#!/bin/bash

# Run the stat command to check the ownership of audit tools
output=$(stat -Lc "%n %U" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | awk '$2 != "root" {print}')

# Check if there is any output from the stat command
if [ -z "$output" ]; then
    echo "PASSED!! All audit tools are owned by root."
else
    echo "FAILED!! The following audit tools need to be remediated:"
    echo "$output"
fi

