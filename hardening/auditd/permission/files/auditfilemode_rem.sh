#!/bin/bash
find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec chmod u-x,g-wx,o-rwx {} +
echo
echo "Remediation complete!!"
echo

