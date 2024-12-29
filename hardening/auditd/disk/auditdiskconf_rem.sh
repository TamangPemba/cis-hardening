augenrules --load
echo
if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then echo "Reboot required to load rules"; fi
echo
echo "Remediation complete!!"
echo

