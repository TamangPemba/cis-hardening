#!/bin/bash

# Run the command to check for the specified audit rule
output=$(awk '/^ *-w/ \
&&/\/etc\/sudoers/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
echo
# Check the output
if [ -z "$output" ]; then
    echo "FAILED!! Need to remediate"
else
    echo "$output"
    echo
    echo "PASSED!!"
    echo
fi

