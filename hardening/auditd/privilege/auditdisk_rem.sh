#!/usr/bin/env bash
{
 UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
 AUDIT_RULE_FILE="/etc/audit/rules.d/privileged.rules"
 NEW_DATA=()
 for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do
 readarray -t DATA < <(find "${PARTITION}" -xdev -perm /6000 -type f | awk -v UID_MIN=${UID_MIN} '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>="UID_MIN" -F auid!=unset -k privileged" }')
 for ENTRY in "${DATA[@]}"; do
 NEW_DATA+=("${ENTRY}")
 done
 done
 readarray &> /dev/null -t OLD_DATA < "${AUDIT_RULE_FILE}"
 COMBINED_DATA=( "${OLD_DATA[@]}" "${NEW_DATA[@]}" )
 printf '%s\n' "${COMBINED_DATA[@]}" | sort -u > "${AUDIT_RULE_FILE}"
}

echo
augenrules --load
echo
if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then printf "Reboot required to load rules\n"; fi
echo
echo "Remediation complete!!"
echo
