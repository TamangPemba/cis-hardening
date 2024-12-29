#!/bin/bash

# Extract the sudo log file path from /etc/sudoers
SUDO_LOG_FILE=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,?.*//' -e 's/"//g' -e 's|/|\\/|g')

if [ -z "$SUDO_LOG_FILE" ]; then
    echo "ERROR: Variable 'SUDO_LOG_FILE' is unset or no logfile directive found in /etc/sudoers."
    exit 1
fi

# Check audit rules in /etc/audit/rules.d/
file_output=$(awk "/^ *-w/ \
&&/${SUDO_LOG_FILE}/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules)

# Check audit rules in currently loaded auditctl rules
auditctl_output=$(auditctl -l | awk "/^ *-w/ \
&&/${SUDO_LOG_FILE}/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)")

# Evaluate results
if [ -z "$file_output" ] && [ -z "$auditctl_output" ]; then
    echo "FAILED!! Need to remediate"
else
    echo "Output from audit rules files:"
    echo "$file_output"
    echo
    echo "Output from auditctl:"
    echo "$auditctl_output"
    echo
    echo "PASSED!!"
fi

