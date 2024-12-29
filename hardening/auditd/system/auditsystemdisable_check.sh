#!/bin/bash

# Check for disk_full_action and disk_error_action values
disk_full_action=$(grep -Pi -- '^\h*disk_full_action\h*=\h*(halt|single)\b' /etc/audit/auditd.conf)
disk_error_action=$(grep -Pi -- '^\h*disk_error_action\h*=\h*(syslog|single|halt)\b' /etc/audit/auditd.conf)

# Check if both conditions are met
if [[ -z "$disk_full_action" && -z "$disk_error_action" ]]; then
    echo "FAILED!! Need to remediate"
else
    echo "PASSED!!"
    if [[ -n "$disk_full_action" ]]; then
        echo "$disk_full_action"
    fi
    if [[ -n "$disk_error_action" ]]; then
        echo "$disk_error_action"
    fi
fi

