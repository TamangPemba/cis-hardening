#!/bin/bash
systemctl unmask auditd
systemctl enable auditd
systemctl start auditd
