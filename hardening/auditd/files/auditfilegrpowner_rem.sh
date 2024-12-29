find $(dirname $(awk -F"=" '/^\s*log_file/ {print $2}' /etc/audit/auditd.conf | xargs)) -type f \( ! -group adm -a ! -group root \) -exec chgrp adm {} +
sed -ri 's/^\s*#?\s*log_group\s*=\s*\S+(\s*#.*)?.*$/log_group = adm\1/' /etc/audit/auditd.conf
echo
systemctl restart auditd
echo
echo "Remediation complete!!"
echo

