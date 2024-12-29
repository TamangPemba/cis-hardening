printf '\n%s' "-e 2" > /etc/audit/rules.d/finalize.rules
echo
augenrules --load
echo
if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then printf "Reboot required to load rules\n"; fi
echo
echo "Remediation complete!!"
echo
