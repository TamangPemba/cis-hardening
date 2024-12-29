#!/bin/bash

# Check for even_deny_root
if grep -qP '^\h*even_deny_root\b' /etc/security/faillock.conf; then
    echo "even_deny_root is set: Passed"
else
    echo "even_deny_root is not set: Failed"
fi

# Check for root_unlock_time >= 60
if grep -qP '^\h*root_unlock_time\h*=\h*[6-9][0-9][0-9]*\b' /etc/security/faillock.conf; then
    echo "root_unlock_time is set to 60 or more: Passed"
else
    echo "root_unlock_time is less than 60: Failed"
fi

# Check for pam_faillock.so settings in /etc/pam.d/common-auth
if grep -Pi -- '^\h*auth\h+([^#\n\r]+\h+)pam_faillock\.so\h+([^#\n\r]+\h+)?root_unlock_time\h*=\h*([1-9]|[1-5][0-9])\b' /etc/pam.d/common-auth; then
    echo "Failed!! root_unlock_time in pam_faillock.so is set improperly"
else
    echo "Passed!! root_unlock_time in pam_faillock."
fi
