#!/bin/bash

# Run the augenrules check to verify audit rules configuration
output=$(augenrules --check)

# Check if any error is found in the output
if echo "$output" | grep -q "audit.rules file(s) missing"; then
    echo "FAILED!! The audit rules configuration is missing or incorrect."
    echo "$output"
else
    echo "PASSED!! The audit rules are correctly configured."
    echo "$output"
fi

