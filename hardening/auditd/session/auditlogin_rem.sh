#!/bin/bash
printf "
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock -p wa -k logins
" > /etc/audit/rules.d/login.rules
echo
augenrules --load
echo
if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then printf "Reboot required to load rules\n"; fi
echo
echo "Remediation complete!!"
echo
