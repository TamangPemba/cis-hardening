#!/usr/bin/env bash

CONFIG_FILE="/etc/security/faillock.conf"

# Settings to ensure
REQUIRED_SETTINGS=(
    "even_deny_root"
    "root_unlock_time=9000"
)
echo
# Ensure the configuration file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    touch "$CONFIG_FILE"
    echo "Configuration file '$CONFIG_FILE' created."
fi

for setting in "${REQUIRED_SETTINGS[@]}"; do
    # Check if the setting is present, commented, or missing
    if grep -Eq "^$setting" "$CONFIG_FILE"; then
        echo "'$setting' is already set correctly in '$CONFIG_FILE'."
    elif grep -Eq "^#\s*$setting" "$CONFIG_FILE"; then
        # Uncomment the line if it is commented
        sed -i "s/^#\s*\($setting\)/\1/" "$CONFIG_FILE"
        echo "'$setting' was commented and is now uncommented in '$CONFIG_FILE'."
    else
        # Add the setting if it's missing
        echo "$setting" >>"$CONFIG_FILE"
        echo "'$setting' was missing and has been added to '$CONFIG_FILE'."
    fi
done
echo
echo "Remediation Complete!!"
echo
