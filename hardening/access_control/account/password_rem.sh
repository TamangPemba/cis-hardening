#!/bin/bash

# File paths
LOGIN_DEFS="/etc/login.defs"
SHADOW_FILE="/etc/shadow"

# Remediate PASS_MIN_DAYS in /etc/login.defs
if grep -Pi -- '^\h*PASS_MIN_DAYS\h+\d+\b' $LOGIN_DEFS | awk '{if($2 < 1) print "PASS_MIN_DAYS is set to a value less than 1, needs remediation"}'; then
    echo "PASS_MIN_DAYS is set to less than 1. Remediating..."

    # Backup the file before making changes
    cp $LOGIN_DEFS ${LOGIN_DEFS}.bak
    echo "Backup of $LOGIN_DEFS created at ${LOGIN_DEFS}.bak"

    # Edit /etc/login.defs to set PASS_MIN_DAYS to 1 (or your policy)
    sed -i 's/^\s*PASS_MIN_DAYS\s\+[0-9]\+/PASS_MIN_DAYS 1/' $LOGIN_DEFS
    echo "PASS_MIN_DAYS has been set to 1 in /etc/login.defs"
fi

# Remediate users with PASS_MIN_DAYS < 1 in /etc/shadow
awk -F: '($2~/^\$.+\$/) {if($4 < 1)print "User: " $1 " PASS_MIN_DAYS: " $4}' $SHADOW_FILE | while read -r user_line; do
    # Extract the user name
    user=$(echo $user_line | awk '{print $2}')

    # Set the minimum password age to 1 (or your policy) using chage
    chage --mindays 1 $user
    echo "User $user has been updated to have PASS_MIN_DAYS >= 1"
done

echo "Remediation complete."

