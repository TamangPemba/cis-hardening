#!/bin/bash

# Get UID_MIN from /etc/login.defs
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

# Check if UID_MIN is set and perform the audit check for ACL related syscalls
if [ -n "${UID_MIN}" ]; then
    # Check audit rules for ACL related syscalls
    file_output=$(awk "/^ *-a *always,exit/ \
    &&/ -F *arch=b(32|64)/ \
    &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
    &&/ -S/ \
    &&/ -F *auid>=${UID_MIN}/ \
    &&(/chmod/||/fchmod/||/fchmodat/ \
    ||/chown/||/fchown/||/fchownat/||/lchown/ \
    ||/setxattr/||/lsetxattr/||/fsetxattr/ \
    ||/removexattr/||/lremovexattr/||/fremovexattr/) \
    &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules)

    # Check auditctl for ACL related syscalls
    auditctl_output=$(auditctl -l | awk "/^ *-a *always,exit/ \
    &&/ -F *arch=b(32|64)/ \
    &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
    &&/ -S/ \
    &&/ -F *auid>=${UID_MIN}/ \
    &&(/chmod/||/fchmod/||/fchmodat/ \
    ||/chown/||/fchown/||/fchownat/||/lchown/ \
    ||/setxattr/||/lsetxattr/||/fsetxattr/ \
    ||/removexattr/||/lremovexattr/||/fremovexattr/) \
    &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)")

    # Combine results
    if [ -z "$file_output" ] && [ -z "$auditctl_output" ]; then
        echo "FAILED!! Need to remediate"
    else
        echo "Output from audit rules files (for ACL syscalls):"
        echo "$file_output"
        echo
        echo "Output from auditctl (for ACL syscalls):"
        echo "$auditctl_output"
        echo
        echo "PASSED!!"
    fi
else
    echo "ERROR: Variable 'UID_MIN' is unset."
fi

