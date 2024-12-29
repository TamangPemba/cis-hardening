#!/bin/bash

# Check audit rules in /etc/audit/rules.d/
file_output=$(awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&(/ -C *euid!=uid/||/ -C *uid!=euid/) \
&&/ -S *execve/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

# Check audit rules in currently loaded auditctl rules
auditctl_output=$(auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&(/ -C *euid!=uid/||/ -C *uid!=euid/) \
&&/ -S *execve/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')

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

