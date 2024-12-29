#!/bin/bash

# Check if the log_group configuration is set correctly in /etc/audit/auditd.conf
grep -Piws -- '^\h*log_group\h*=\h*\H+\b' /etc/audit/auditd.conf | grep -Pvi -- '(adm)'

# Check if the auditd.conf file exists and is configured properly
if [ -e /etc/audit/auditd.conf ]; then
    # Get the log file path from auditd.conf
    l_fpath="$(dirname "$(awk -F "=" '/^\s*log_file/ {print $2}' /etc/audit/auditd.conf | xargs)")"
    
    # Find files in the log directory that are not owned by 'root' or 'adm' groups
    find -L "$l_fpath" -not -path "$l_fpath"/lost+found -type f \( ! -group root -a ! -group adm \) -exec ls -l {} +
else
    echo "ERROR: /etc/audit/auditd.conf does not exist."
fi

