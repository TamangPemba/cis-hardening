#!/bin/bash
echo 'Defaults logfile="/var/log/sudo.log"' > /etc/sudoers.d/sudolog
# Extract the sudo log file path from /etc/sudoers
SUDO_LOG_FILE=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,?.*//' -e 's/"//g')

if [ -z "$SUDO_LOG_FILE" ]; then
    echo "ERROR: Variable 'SUDO_LOG_FILE' is unset or no logfile directive found in /etc/sudoers."
    exit 1
fi

# Check if the rule already exists in the audit rules
if ! grep -qP "^\s*-w\s+${SUDO_LOG_FILE//\//\\/}\s+-p\s+wa\s+-k\s+sudo_log_file\s*$" /etc/audit/rules.d/sudolog.rules; then
    # Add the rule if it doesn't exist
    echo " -w ${SUDO_LOG_FILE} -p wa -k sudo_log_file " > /etc/audit/rules.d/sudolog.rules
    echo "Added rule for sudo log file: -w ${SUDO_LOG_FILE} -p wa -k sudo_log_file"
else
    echo "Rule for sudo log file already exists."
fi

# Reload audit rules
augenrules --load

# Check if a reboot is required to load rules
if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then
    echo "Reboot required to load rules."
fi
echo
echo "Remediation complete!!"
echo
