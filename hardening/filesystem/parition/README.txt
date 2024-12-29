Need to create seprate partition and on different directories. 

i.e. 

/home	     	defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0 
/var     	defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0 
/var/log  	defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0
var/tmp	  	defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0
/var/log/audit 	defaults,rw,nosuid,nodev,noexec,relatime,seclabel 0 0


#Verification

findmnt -kn /home
findmnt -kn /var/tmp
findmnt -kn /var
findmnt -kn /var/log
findmnt -kn /var/log/audit
