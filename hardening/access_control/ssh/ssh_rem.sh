#!/bin/bash

ISSUE_NET="/etc/issue.net"
MOTD="/etc/motd"
SSH_CONFIG="/etc/ssh/sshd_config"

ISSUE_NET_CONTENT=$(cat << 'EOF'
--------------------------------------------------------------------------
|                       * NOTICE TO USERS *                              |
|                                                                        |
| This system is the private property of (Your) XYZ Organization         |
|               It is for authorized use only.                           |
|                                                                        |
| Users (authorized or unauthorized) have no explicit or implicit        |
| expectation of privacy.                                                |
|                                                                        |
| Any or all uses of this system and all files on this system may be     |
| intercepted, monitored, recorded, copied, audited, inspected, and      |
| disclosed to your employer, to authorized site, government, and law    |
| enforcement personnel, as well as authorized officials of government   |
| agencies, both domestic and foreign.                                   |
|                                                                        |
| By using this system, the user consents to such interception,          |
| monitoring, recording, copying, auditing, inspection, and disclosure   |
| at the discretion of such personnel or officials.  Unauthorized or     |
| improper use of this system may result in civil and criminal penalties |
| and administrative or disciplinary action, as appropriate. By          |
| continuing to use this system you indicate your awareness of and       |
| consent to these terms and conditions of use. LOG OFF IMMEDIATELY if   |
| you do not agree to the conditions stated in this warning.             |
--------------------------------------------------------------------------
EOF
)

MOTD_CONTENT="XYZ ORGANIZATION AUTHORIZED USE ONLY !!!"

SSH_SERVICE=""
if systemctl list-units --type=service | grep -q "sshd.service"; then
    SSH_SERVICE="sshd"
elif systemctl list-units --type=service | grep -q "ssh.service"; then
    SSH_SERVICE="ssh"
else
    echo "Error: Unable to determine SSH service name."
    exit 1
fi

# Update /etc/issue.net
if [ "$(cat $ISSUE_NET 2>/dev/null)" != "$ISSUE_NET_CONTENT" ]; then
    echo "$ISSUE_NET_CONTENT" > $ISSUE_NET
    echo "/etc/issue.net updated."
else
    echo "/etc/issue.net is already up-to-date."
fi

# Update /etc/motd
if [ "$(cat $MOTD 2>/dev/null)" != "$MOTD_CONTENT" ]; then
    echo "$MOTD_CONTENT" > $MOTD
    echo "/etc/motd updated."
else
    echo "/etc/motd is already up-to-date."
fi

# Update sshd_config
update_sshd_config() {
    local key="$1"
    local value="$2"
    if grep -q "^$key" $SSH_CONFIG; then
        sed -i "s|^$key .*|$key $value|" $SSH_CONFIG
        echo "Updated $key to $value in sshd_config."
    else
        echo "$key $value" >> $SSH_CONFIG
        echo "Added $key directive to sshd_config."
    fi
}

# Update SSH settings
update_sshd_config "Banner" "/etc/issue.net"
update_sshd_config "X11Forwarding" "no"
update_sshd_config "DisableForwarding" "yes"
update_sshd_config "GSSAPIAuthentication" "no"

# Restart SSH service
systemctl restart $SSH_SERVICE
echo "$SSH_SERVICE service restarted."

