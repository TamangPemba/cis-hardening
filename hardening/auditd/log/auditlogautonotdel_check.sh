#!/bin/bash

# Check if max_log_file_action is set to ROTATE in /etc/audit/auditd.conf
if grep -P '^max_log_file_action\s*=\s*ROTATE' /etc/audit/auditd.conf > /dev/null; then
    echo "FAILED!! need to remediate"
elif grep -P '^max_log_file_action\s*=\s*keep_logs' /etc/audit/auditd.conf > /dev/null; then
    echo "PASSED!!"
else
    echo "No setting found for max_log_file_action"
fi

