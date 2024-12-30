# Ubuntu 24.04 Hardening Scripts

This repository is designed to automate the hardening process for **Ubuntu 24.04**, following the **CIS Ubuntu Linux 24.04 LTS Benchmark v1.0.0 (08-26-2024)**. The structure is organized to focus on various areas of system security, ensuring each component is properly configured and checked. 

### Overview

The **`/hardening`** directory is the parent directory containing various subdirectories for different security areas like access control, auditd, filesystem, network, and services.

- **`access_control/`** contains scripts related to user access management, such as security configuration for PAM, sudo, and SSH.
- **`auditd/`** contains scripts and configuration for audit logging, including cryptographic settings, audit log sizes, and system auditing.
- **`filesystem/`** focuses on partitioning and filesystem hardening.
- **`network/`** contains network-related hardening scripts.
- **`services/`** contains scripts for service hardening.
- **`ubuntu24_check.sh`** is used to verify existing configurations.
- **`ubuntu24_rem.sh`** applies remediation changes.

### Purpose

Initially, these tasks were done manually, but I decided to automate the process to ensure consistency and reliability. This repository provides an easy way to automate Ubuntu 24.04 LTS hardening tasks, making it useful for both personal use and larger environments.

### Files You Need to Read

1. **`/hardening/access_control/pam/security_rem.sh`** - Script for PAM security configurations.
2. **`/hardening/access_control/privilege/sudo_rem.sh`** - Remediation for sudo privilege configurations.
3. **`/hardening/access_control/ssh/ssh_rem.sh`** - SSH security hardening script.
4. **`/hardening/filesystem/parition/README.txt`** - Information on partitioning and file system security.
5. **`/hardening/auditd/cryptographic/README.txt`** - Documentation for cryptographic audit settings.
6. **`/hardening/auditd/log/auditbackloglimit_check.sh`** - Script to adjust audit backlog limits based on system workload (default: `8192`).
7. **`/hardening/auditd/log/auditlogsize_rem.sh`** - Script to configure the maximum log file size (default: 8 MiB).
8. **`/hardening/auditd/system/auditsystemdisable_rem.sh`** - Remediation script to disable system auditing (currently set to single).
9. **`/hardening/auditd/system/auditsystem_warn.sh`** - Script to manage audit system warnings (currently in suspend mode).

### Configuration Details

These settings are configurable, and you can adjust them based on your requirements:

- **`max_log_file_action = keep_logs`**
  A value of `keep_logs` will rotate the logs but never delete old logs.

- **`max_log_file = 8`**
  Configure the maximum size of the audit log file. Once the log reaches the maximum size (in megabytes), it will rotate, and a new log file will be started.

- **`GRUB_CMDLINE_LINUX="audit=1"`**
  This ensures that processes capable of being audited are audited even if they start up prior to `auditd` startup. To apply this, edit the `/etc/default/grub` file.

- **`GRUB_CMDLINE_LINUX="audit_backlog_limit=8192"`**
  This kernel boot parameter ensures that the audit backlog cannot grow beyond a certain size (default: `8192`).

- **`disk_full_action = single`**
  When no free space is available on the partition holding the audit logs, the system will enter single-user mode.

- **`disk_error_action = single`**
  In case of disk errors, the system will enter single-user mode to prevent further issues.

- **`space_left_action = suspend`**
  When disk space is low, the audit daemon will stop writing records to the disk.

- **`admin_space_left_action = suspend`**
  Similar to the `space_left_action`, but applied to administrator space left.

### Manual and Automated Work

While initially, all of the configurations and checks were done manually, I have automated most of the tasks here. The manual part is noted in the specific README and script files. Please read the files mentioned above to understand how each step works and what can be customized.

### Future Enhancements

- Further automation can be introduced to handle additional checks and remediations.
- More configurations related to services and network hardening are planned for inclusion.


### Key Scripts:
- **`ubuntu24_check.sh`**: Checks the system configuration against CIS benchmarks.
- **`ubuntu24_rem.sh`**: Applies the necessary remediations for hardening.

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/TamangPemba/cis-hardening.git
   cd cis-hardening
   ```

2. Run the check script:
   ```bash
    sudo bash hardening/ubuntu24_check.sh
   ```
3. Run the remediation script:
   ```bash
    sudo bash hardening/ubuntu24_rem.sh
   ```

5. Clean up temporary files (if you terminate while executing script!):
   ```bash
    sudo rm -f /tmp/ubuntu_24*
   ```

These scripts follow the CIS Ubuntu 24.04 LTS Benchmark and help secure your system by applying best practices for system hardening.

## Thank You! 
