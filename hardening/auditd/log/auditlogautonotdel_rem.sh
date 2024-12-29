#!/bin/bash

# Ensure max_log_file_action is set to keep_logs
grep -q '^max_log_file_action\s*=' /etc/audit/auditd.conf && \
sed -i 's/^max_log_file_action\s*=.*/max_log_file_action = keep_logs/' /etc/audit/auditd.conf || \
echo 'max_log_file_action = keep_logs' >> /etc/audit/auditd.conf
echo
echo "Remediation complete!!"
echo
