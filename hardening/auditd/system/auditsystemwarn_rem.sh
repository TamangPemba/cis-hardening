#!/bin/bash

# Check if space_left_action is set correctly, if not update it
if ! grep -Pi -- '^\h*space_left_action\h*=\h*(email|exec|suspend|single|halt)\b' /etc/audit/auditd.conf; then
    # If not set correctly, update to "suspend"
    sed -i 's/^\h*space_left_action.*/space_left_action = suspend/' /etc/audit/auditd.conf
    echo "Updated space_left_action to suspend."
fi

# Check if admin_space_left_action is set correctly, if not update it
if ! grep -Pi -- '^\h*admin_space_left_action\h*=\h*(single|suspend|halt)\b' /etc/audit/auditd.conf; then
    # If not set correctly, update to "single"
    sed -i 's/^\h*admin_space_left_action.*/admin_space_left_action = suspend/' /etc/audit/auditd.conf
    echo "Updated admin_space_left_action to suspend."
fi

# Ensure no incorrect values are present and only the correct ones remain
sed -i '/^\h*space_left_action\h*=\h*(?!email|exec|single|suspend|halt).*/ s/.*/space_left_action = suspend/' /etc/audit/auditd.conf
sed -i '/^\h*admin_space_left_action\h*=\h*(?!single|suspend|halt).*/ s/.*/admin_space_left_action = suspend/' /etc/audit/auditd.conf

# Completion message
echo "Remediation complete"

