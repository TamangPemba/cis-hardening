#!/bin/bash

# Command to check for audit_backlog_limit in grub.cfg
output=$(find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\s*linux' {} + | grep -Pv 'audit_backlog_limit=\d+\b')

# Check the result and provide the appropriate message
echo
if [ -n "$output" ]; then
    echo "FAILED!! Remediation is needed."
    echo "Details:"
    echo "$output"
else
    echo "PASSED!!"
fi
echo

