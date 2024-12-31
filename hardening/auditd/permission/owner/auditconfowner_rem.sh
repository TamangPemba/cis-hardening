#!/bin/bash
find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root -exec chown root {} +
echo
echo "Remediation complete"
echo

