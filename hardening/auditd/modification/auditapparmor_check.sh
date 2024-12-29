#!/bin/bash

# Check audit rules for AppArmor directories in rules files
file_output=$(awk '/^ *-w/ \
&&(/\/etc\/apparmor/ \
 ||/\/etc\/apparmor.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

# Check auditctl for AppArmor directories
auditctl_output=$(auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/apparmor/ \
 ||/\/etc\/apparmor.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')

# Combine results
if [ -z "$file_output" ] && [ -z "$auditctl_output" ]; then
    echo "FAILED!! Need to remediate"
else
    echo "Output from audit rules files (for AppArmor directories):"
    echo "$file_output"
    echo
    echo "Output from auditctl (for AppArmor directories):"
    echo "$auditctl_output"
    echo
    echo "PASSED!!"
fi

