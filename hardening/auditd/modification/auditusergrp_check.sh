#!/bin/bash

# Check audit rules for user/group configuration files
file_output_1=$(awk '/^ *-w/ \
&&(/\/etc\/group/ \
 ||/\/etc\/passwd/ \
 ||/\/etc\/gshadow/ \
 ||/\/etc\/shadow/ \
 ||/\/etc\/security\/opasswd/ \
 ||/\/etc\/nsswitch.conf/ \
 ||/\/etc\/pam.conf/ \
 ||/\/etc\/pam.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

# Check auditctl for user/group configuration files
auditctl_output_1=$(auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/group/ \
 ||/\/etc\/passwd/ \
 ||/\/etc\/gshadow/ \
 ||/\/etc\/shadow/ \
 ||/\/etc\/security\/opasswd/ \
 ||/\/etc\/nsswitch.conf/ \
 ||/\/etc\/pam.conf/ \
 ||/\/etc\/pam.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')

# Combine results
if [ -z "$file_output_1" ] && [ -z "$auditctl_output_1" ]; then
    echo "FAILED!! Need to remediate"
else
    echo "Output from audit rules files (for user/group configuration files):"
    echo "$file_output_1"
    echo
    echo "Output from auditctl (for user/group configuration files):"
    echo "$auditctl_output_1"
    echo
    echo "PASSED!!"
fi

