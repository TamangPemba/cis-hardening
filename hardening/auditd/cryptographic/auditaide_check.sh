#!/usr/bin/env bash

# Initialize arrays for storing results
a_output=()
a_output2=()

# Directory of audit tools
l_tool_dir="$(readlink -f /sbin)"

# Items to check for in AIDE config files
a_items=("p" "i" "n" "u" "g" "s" "b" "acl" "xattrs" "sha512")

# Path to AIDE command
l_aide_cmd=$(whereis aide | awk '{print $2}')

# List of audit tool files to check
a_audit_files=("auditctl" "auditd" "ausearch" "aureport" "autrace" "augenrules")

# Function to check each file for required configuration options
f_file_par_chk() {
    a_out2=()
    
    # Check each item in the AIDE config
    for l_item in "${a_items[@]}"; do
        # If item is missing in the config, add to output
        if ! grep -Psiq -- '(\h+|\+)'"$l_item"'(\h+|\+)' <<< "$l_out"; then
            a_out2+=(" - Missing the \"$l_item\" option")
        fi
    done

    # Output results based on whether options were found
    if [ "${#a_out2[@]}" -gt "0" ]; then
        a_output2+=(" - Audit tool file: \"$l_file\"" "${a_out2[@]}")
    else
        a_output+=(" - Audit tool file: \"$l_file\" includes:" "\"${a_items[*]}\"")
    fi
}

# Check if AIDE is installed and proceed
if [ -f "$l_aide_cmd" ] && command -v "$l_aide_cmd" &>/dev/null; then
    # Find AIDE configuration files
    a_aide_conf_files=($(find -L /etc -type f -name 'aide.conf'))

    # Loop through each audit tool file
    for l_file in "${a_audit_files[@]}"; do
        if [ -f "$l_tool_dir/$l_file" ]; then
            # Run AIDE with configuration file and check for required options
            l_out="$("$l_aide_cmd" --config "${a_aide_conf_files[@]}" -p f:"$l_tool_dir/$l_file")"
            f_file_par_chk
        else
            a_output+=(" - Audit tool file \"$l_file\" doesn't exist")
        fi
    done
else
    a_output2+=(" - The command \"aide\" was not found. Please install AIDE.")
fi

# Final output based on audit results
if [ "${#a_output2[@]}" -le 0 ]; then
    printf '%s\n' "" "- Audit Result:" " ** PASS **" "${a_output[@]}" ""
else
    printf '%s\n' "" "- Audit Result:" " ** FAIL **" " - Reason(s) for audit failure:" "${a_output2[@]}"
    [ "${#a_output[@]}" -gt 0 ] && printf '%s\n' "" "- Correctly set:" "${a_output[@]}" ""
fi

