#!/bin/bash
results=$(grep -r "^[^#].*NOPASSWD" /etc/sudoers* 2>/dev/null)
if [ -n "$results" ]; then
    echo "FAILED!! NOPASSWD is present in /etc/sudoers or its included files."
    echo
    echo "The following lines contain NOPASSWD:"
    echo "$results"
else
    echo "PASSED!!"
fi

