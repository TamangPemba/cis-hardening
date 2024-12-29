Need to Create seprated partition like and mounted on different directories. 
i.g.
/home     defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0 
/var      defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0 
/var/log  defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0
var/tmp	  defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0
/var/log/audit defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0

same on different partition. 
Verification
findmnt -kn /home
findmnt -kn /var/tmp
findmnt -kn /var
findmnt -kn /var/log
findmnt -kn /var/log/audit
