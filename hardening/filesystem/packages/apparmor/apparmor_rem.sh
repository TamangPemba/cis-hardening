#!/bin/bash

# Run apparmor_check.sh and capture the output
check_output=$(./apparmor_check.sh)

# Check if apparmor_check.sh produced any output
if [ -z "$check_output" ]; then
    echo
    echo "apparmor_check.sh produced no output. Running apparmor_rem.sh..."
            aa-enforce /etc/apparmor.d/*
else   
	echo
	echo "apparmor_check.sh produced output(alreay on enforcing mode)."
	echo
	echo "Skipping apparmor_rem.sh.(PASSED!!)"
	echo
fi

