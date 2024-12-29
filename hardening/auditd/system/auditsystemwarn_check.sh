#!/bin/bash

# Check if space_left_action is set to one of the desired values (email, exec, single, halt)
if ! grep -P -- '^\h*space_left_action\h*=\h*(email|exec|single|suspend|halt)\b' /etc/audit/auditd.conf; then
    echo "FAILED!! Need to remediate"
else
    echo "PASSED!! space_left_action is set correctly"
fi

# Check if admin_space_left_action is set to either 'single' or 'halt'
if ! grep -P -- '^\h*admin_space_left_action\h*=\h*(single|suspend|halt)\b' /etc/audit/auditd.conf; then
    echo "FAILED!! Need to remediate"
else
    echo "PASSED!! admin_space_left_action is set correctly"
fi

