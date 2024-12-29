#!/bin/bash

# Check if auditd service is enabled
if systemctl is-enabled auditd | grep -q '^enabled'; then
    echo "PASSED!! auditd service is enabled"
else
    echo "FAILED !! auditd service is not enabled"
fi

# Check if auditd service is active
if systemctl is-active auditd | grep -q '^active'; then
    echo "PASSED!! auditd service is active"
else
    echo "FAILED !! auditd service is not active"
fi

