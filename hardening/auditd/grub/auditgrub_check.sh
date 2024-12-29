#!/bin/bash

# Check for 'audit=1' in GRUB configuration
result=$(find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\s*linux' {} + | grep -v 'audit=1')
echo
if [ -n "$result" ]; then
    echo "FAILED!! Need to remediate. The following entries are missing 'audit=1':"
    echo "$result"
else
    echo "PASSED!! All GRUB entries contain 'audit=1'."
fi
echo
