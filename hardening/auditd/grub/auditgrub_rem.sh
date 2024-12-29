#!/bin/bash

# Check if audit=1 is already present, if not, append it
if ! grep -q 'audit=1' /etc/default/grub; then
    sed -i.bak '/^GRUB_CMDLINE_LINUX/ s/"$/audit=1"/' /etc/default/grub
    echo "audit=1 added to GRUB_CMDLINE_LINUX."
    update-grub
else
    echo "audit=1 is already set in GRUB_CMDLINE_LINUX. No changes made."
fi

echo "Remediation complete. Please reboot for changes to take effect."

