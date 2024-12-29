# cis
Hardening OS based on CIS benchmark Level 2  Server
Run:
    ubuntu24_rem.sh (running remediation scripts, based on CIS benchmark Level2 Server.
once complete, run rm -rvf /tmp/* 
Run:
    ubuntu24_check.sh
once complete, run rm -rvf /tmp/* 

audit configuration:

max_log_file_action = keep_logs  	A value of keep_logs will rotate the logs but never delete old logs.
max_log_file = 8	Configure the maximum size of the audit log file. Once the log reaches the maximum size, it will be rotated and a new log file will be started. (measured in megabytes)
GRUB_CMDLINE_LINUX="audit=1" 	Configure grub2 so that processes that are capable of being audited can be audited even if they start up prior to auditd startup. (edit on /etc/default/grub)
GRUB_CMDLINE_LINUX="audit_backlog_limit=8192" 	The kernel boot parameter audit_backlog_limit=N, with N representing the amount of messages, will ensure that a queue cannot grow beyond a certain size. If an audit event is logged which would grow the queue beyond this limit, then a failure occurs and is handled according to the system configuration
disk_full_action = single	tells the system what action to take when no free space is available on the partition that holds the audit log files.

Set to single - the auditd daemon will put the computer system in single user mode when the disk partition containing the audit logs becomes full.
disk_error_action = single 	tells the system what action to take when an error is detected on the partition that holds the audit log files.

Set to single - the auditd daemon will put the computer system in single user
space_left_action = suspend	tells the system what action to take when the system has detected that it is starting to get low on disk space.

suspend, the audit daemon will stop writing records to the disk
admin_space_left_action = suspend	 "

