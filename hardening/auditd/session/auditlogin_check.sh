#!/bin/bash

# Check audit rules for login/logout-related files in rules files
file_output=$(awk '/^ *-w/ \
&&(/\/var\/log\/lastlog/ \
 ||/\/var\/run\/faillock/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

# Check auditctl for login/logout-related files
auditctl_output=$(auditctl -l | awk '/^ *-w/ \
&&(/\/var\/log\/lastlog/ \
 ||/\/var\/run\/faillock/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')

# Combine results
if [ -z "$file_output" ] && [ -z "$auditctl_output" ]; then
    echo "FAILED!! Need to remediate"
else
    echo "Output from audit rules files (for login/logout-related files):"
    echo "$file_output"
    echo
    echo "Output from auditctl (for login/logout-related files):"
    echo "$auditctl_output"
    echo
    echo "PASSED!!"
fi

