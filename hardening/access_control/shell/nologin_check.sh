#!/bin/bash

SHELLS_FILE="/etc/shells"
echo
# Check if /nologin is listed in /etc/shells
if grep -Ps '^\h*([^#\n\r]+)?\/nologin\b' $SHELLS_FILE; then
    echo "FAILED!! nologin is listed in /etc/shells. Remediation needed."
else
    echo "PASSED!! nologin is not listed in /etc/shells."
fi
echo
