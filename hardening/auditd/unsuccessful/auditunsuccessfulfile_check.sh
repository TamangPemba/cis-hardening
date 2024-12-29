#!/bin/bash

# Check for UID_MIN in /etc/login.defs
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

if [ -n "${UID_MIN}" ]; then
    # Check audit rules for unsuccessful file access attempts
    file_output_1=$(awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) \
&&/ -S/ \
&&/creat/ \
&&/open/ \
&&/truncate/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules)

    auditctl_output_1=$(auditctl -l | awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) \
&&/ -S/ \
&&/creat/ \
&&/open/ \
&&/truncate/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)")

    # Combine results
    if [ -z "$file_output_1" ] && [ -z "$auditctl_output_1" ]; then
        echo "FAILED!! Need to remediate"
    else
        echo "Output from audit rules files (for unsuccessful file access attempts):"
        echo "$file_output_1"
        echo
        echo "Output from auditctl (for unsuccessful file access attempts):"
        echo "$auditctl_output_1"
        echo
        echo "PASSED!!"
    fi
else
    echo "ERROR: Variable 'UID_MIN' is unset."
fi

