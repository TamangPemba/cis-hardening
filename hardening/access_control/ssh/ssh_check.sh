#!/bin/bash
sshd -T | grep -i disableforwarding
sshd -T | grep gssapiauthentication


