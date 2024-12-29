#!/bin/bash

# Check if the audit configuration has '-e 2' for automatic audit event rule
output=$(grep -Ph -- '^\h*-e\h+2\b' /etc/audit/rules.d/*.rules | tail -1)

# Check if output is found
if [ -z "$output" ]; then
    echo "FAILED!! The audit rule '-e 2' is not set in the audit rules files."
else
    echo "PASSED!! The audit rule '-e 2' is set in the following file:"
    echo "$output"
fi

