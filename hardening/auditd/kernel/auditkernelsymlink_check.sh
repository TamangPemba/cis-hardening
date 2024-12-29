#!/usr/bin/env bash
{
 a_files=("/usr/sbin/lsmod" "/usr/sbin/rmmod" "/usr/sbin/insmod"
"/usr/sbin/modinfo" "/usr/sbin/modprobe" "/usr/sbin/depmod")
 for l_file in "${a_files[@]}"; do
 if [ "$(readlink -f "$l_file")" = "$(readlink -f /bin/kmod)" ]; then
 printf "OK: \"$l_file\"\n"
 else
 printf "Issue with symlink for file: \"$l_file\"\n"
 fi
 done
}

