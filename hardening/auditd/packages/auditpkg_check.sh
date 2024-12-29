#!/bin/bash
echo
# Check if auditd package is installed
if dpkg-query -s auditd &>/dev/null; then
    echo "PASSED!! pkg auditd is present"
else
    echo "FAILED !! pkg auditd not present"
fi
echo
# Check if audispd-plugins package is installed
if dpkg-query -s audispd-plugins &>/dev/null; then
    echo "PASSED!! pkg audispd-plugins is present"
else
    echo "FAILED !! pkg audispd-plugins not present"
fi
echo
