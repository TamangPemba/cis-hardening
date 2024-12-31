#!/bin/bash
echo
echo "===========PROFILES=========="
echo
apparmor_status | grep profiles
echo
echo
echo "===========PROCESSES==========="
echo
apparmor_status | grep processes
echo
