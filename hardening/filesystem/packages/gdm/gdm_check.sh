#!/bin/bash

# Check if the package is installed
dpkg-query -W -f='${binary:Package}\t${Status}\n' gdm3 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "FAILED!! gdm3 is installed"
else
    echo "PASSED!! gdm3 is not installed"
fi

