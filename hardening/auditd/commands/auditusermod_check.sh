#!/bin/bash

# Retrieve UID_MIN from /etc/login.defs
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

# Validate and check audit rules in rule files
if [ -n "${UID_MIN}" ]; then
    file_output=$(awk "/^ *-a *always,exit/ \
    &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
    &&/ -F *auid>=${UID_MIN}/ \
    &&/ -F *perm=x/ \
    &&/ -F *path=\/usr\/sbin\/usermod/ \
    &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules)

    auditctl_output=$(auditctl -l | awk "/^ *-a *always,exit/ \
    &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
    &&/ -F *auid>=${UID_MIN}/ \
    &&/ -F *perm=x/ \
    &&/ -F *path=\/usr\/sbin\/usermod/ \
    &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)")
else
    echo "ERROR: Variable 'UID_MIN' is unset."
    exit 1
fi

# Combine results
if [ -z "$file_output" ] && [ -z "$auditctl_output" ]; then
    echo "FAILED!! Need to remediate."
else
    echo "Output from audit rules files (for usermod usage):"
    echo "$file_output"
    echo
    echo "Output from auditctl (for usermod usage):"
    echo "$auditctl_output"
    echo
    echo "PASSED!!"
fi

