#!/bin/bash
echo
grep -Po -- '^\h*max_log_file\h*=\h*\d+\b' /etc/audit/auditd.conf
echo
echo "Default value is 8 MiB, i.e. if file reach 8 MiB it will create new file | If this value is less, remediate it."
echo
