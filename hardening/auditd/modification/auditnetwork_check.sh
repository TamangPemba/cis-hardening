#!/bin/bash

# Check for audit rules in /etc/audit/rules.d/
file_output_1=$(awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
 ||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

file_output_2=$(awk '/^ *-w/ \
&&(/\/etc\/issue/ \
 ||/\/etc\/issue.net/ \
 ||/\/etc\/hosts/ \
 ||/\/etc\/network/ \
 ||/\/etc\/netplan/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

# Check for audit rules in currently loaded auditctl rules
auditctl_output_1=$(auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
 ||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')

auditctl_output_2=$(auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/issue/ \
 ||/\/etc\/issue.net/ \
 ||/\/etc\/hosts/ \
 ||/\/etc\/network/ \
 ||/\/etc\/netplan/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')

# Combine results
if [ -z "$file_output_1" ] && [ -z "$file_output_2" ] && [ -z "$auditctl_output_1" ] && [ -z "$auditctl_output_2" ]; then
    echo "FAILED!! Need to remediate"
else
    echo "Output from audit rules files (for network-related system calls):"
    echo "$file_output_1"
    echo
    echo "Output from audit rules files (for network-related file access):"
    echo "$file_output_2"
    echo
    echo "Output from auditctl (for network-related system calls):"
    echo "$auditctl_output_1"
    echo
    echo "Output from auditctl (for network-related file access):"
    echo "$auditctl_output_2"
    echo
    echo "PASSED!!"
fi

