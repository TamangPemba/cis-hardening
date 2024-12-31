#!/bin/bash
printf "
-w /etc/apparmor/ -p wa -k MAC-policy
-w /etc/apparmor.d/ -p wa -k MAC-policy
" > /etc/audit/rules.d/MAC-policy.rules
echo
augenrules --load
echo
if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then printf "Reboot required to load rules\n"; fi
echo
echo "Remediation complete!!"
echo
