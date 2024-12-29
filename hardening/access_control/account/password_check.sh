#!/bin/bash

LOGIN_DEFS="/etc/login.defs"
SHADOW_FILE="/etc/shadow"
echo
# Check if PASS_MIN_DAYS is set to a value greater than 0 in /etc/login.defs
if [ $(grep -Pi '^\s*PASS_MIN_DAYS\s+\d+\b' $LOGIN_DEFS | awk '{print $2}') -eq 0 ]; then
    echo "FAILED!! PASS_MIN_DAYS is set to 0. Remediation needed."
else
    echo "PASSED!! PASS_MIN_DAYS is properly set."
fi
echo
# Check for users with PASS_MIN_DAYS < 1 in /etc/shadow
failed_users=$(awk -F: '($2~/^\$.+\$/) {if($4 < 1)print "User: " $1 " PASS_MIN_DAYS: " $4}' $SHADOW_FILE)

if [ -n "$failed_users" ]; then
    echo "The following users have PASS_MIN_DAYS less than 1:"
    echo "$failed_users"
    echo "FAILED!! Remediation needed."
else
    echo "PASSED!! All users have PASS_MIN_DAYS set to 1 or more."
fi
echo
