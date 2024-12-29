#!/bin/bash
echo
echo "Removing gdm3 package and related dependencies"
echo

apt purge gdm3 -y
apt autoremove -y
echo
