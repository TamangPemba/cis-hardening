#!/bin/bash

# Define the recommended backlog limit
BACKLOG_LIMIT="audit_backlog_limit=8192"
GRUB_CONFIG="/etc/default/grub"

# Add the parameter if not already present
if ! grep -q "$BACKLOG_LIMIT" "$GRUB_CONFIG"; then
    sed -i "/^GRUB_CMDLINE_LINUX=/ s/\"\$/ $BACKLOG_LIMIT\"/" "$GRUB_CONFIG"
    update-grub
    echo "Added $BACKLOG_LIMIT to GRUB_CMDLINE_LINUX and updated GRUB."
else
    echo "audit_backlog_limit is already set to the recommended value."
fi

