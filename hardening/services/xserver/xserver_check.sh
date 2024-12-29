#!/bin/bash

# Check if the package is installed
dpkg-query -s xserver-common &>/dev/null

if [ $? -eq 0 ]; then
    echo "FAILED!! xserver-common is installed"
else
    echo "PASSED!! xserver-common is not installed"
fi

