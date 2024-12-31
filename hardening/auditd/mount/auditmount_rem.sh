#!/bin/bash
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf "
-a always,exit -F arch=b32 -S mount -F auid>=$UID_MIN -F auid!=unset -k mounts
-a always,exit -F arch=b64 -S mount -F auid>=$UID_MIN -F auid!=unset -k mounts
" > /etc/audit/rules.d/mounts.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo
augenrules --load
echo
 if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then printf "Reboot required to load rules\n"; fi
echo
echo "Remediation complete!!"
echo
