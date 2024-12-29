#!/bin/bash

# Set disk_full_action to 'single' if not already
if ! grep -Pi -- '^\h*disk_full_action\h*=\h*single\b' /etc/audit/auditd.conf; then
    # Remove any existing disk_full_action entries
    sed -i '/^\h*disk_full_action\h*/d' /etc/audit/auditd.conf
    # Add the desired disk_full_action entry
    echo "disk_full_action = single" >> /etc/audit/auditd.conf
    echo "Updated disk_full_action to single."
fi

# Set disk_error_action to 'single' if not already
if ! grep -Pi -- '^\h*disk_error_action\h*=\h*single\b' /etc/audit/auditd.conf; then
    # Remove any existing disk_error_action entries
    sed -i '/^\h*disk_error_action\h*/d' /etc/audit/auditd.conf
    # Add the desired disk_error_action entry
    echo "disk_error_action = single" >> /etc/audit/auditd.conf
    echo "Updated disk_error_action to single."
fi

echo "Remediation complete."

