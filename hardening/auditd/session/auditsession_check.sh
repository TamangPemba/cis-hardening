#!/bin/bash

# Check audit rules for session-related files in rules files
file_output=$(awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
 ||/\/var\/log\/wtmp/ \
 ||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

# Check auditctl for session-related files
auditctl_output=$(auditctl -l | awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
 ||/\/var\/log\/wtmp/ \
 ||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')

# Combine results
if [ -z "$file_output" ] && [ -z "$auditctl_output" ]; then
    echo "FAILED!! Need to remediate"
else
    echo "Output from audit rules files (for session-related files):"
    echo "$file_output"
    echo
    echo "Output from auditctl (for session-related files):"
    echo "$auditctl_output"
    echo
    echo "PASSED!!"
fi

