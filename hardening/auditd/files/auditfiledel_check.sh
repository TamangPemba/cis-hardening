#!/bin/bash

# Define UID_MIN by reading /etc/login.defs
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

# Check if UID_MIN is set
if [ -z "$UID_MIN" ]; then
    echo "ERROR: Variable 'UID_MIN' is unset."
    exit 1
fi

# Check audit rules for file deletion commands in rules files
file_output=$(awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -S/ \
&&(/unlink/||/rename/||/unlinkat/||/renameat/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules)

# Check auditctl for file deletion commands
auditctl_output=$(auditctl -l | awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -S/ \
&&(/unlink/||/rename/||/unlinkat/||/renameat/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)")

# Combine results
if [ -z "$file_output" ] && [ -z "$auditctl_output" ]; then
    echo "FAILED!! Need to remediate"
else
    echo "Output from audit rules files (for file deletion commands):"
    echo "$file_output"
    echo
    echo "Output from auditctl (for file deletion commands):"
    echo "$auditctl_output"
    echo
    echo "PASSED!!"
fi

