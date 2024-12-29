#!/bin/bash

# Path to the /etc/shells file
SHELLS_FILE="/etc/shells"

# Backup the file before making changes
cp $SHELLS_FILE ${SHELLS_FILE}.bak
echo "Backup of /etc/shells created at ${SHELLS_FILE}.bak"

# Remove lines containing /nologin
sed -i '/\/nologin/d' $SHELLS_FILE
echo "All lines containing '/nologin' have been removed from /etc/shells."

echo "Remediation complete."

