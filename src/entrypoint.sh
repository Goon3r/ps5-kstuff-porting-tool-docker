#!/usr/bin/env bash

# Id arguments given, ensure all arguments given
if [[ $# -ne 0 ]] && [[ $# -ne 3 ]]; then
    echo "Error: Invalid usage"
    echo "Usage: . <ip> <port> <fw_version>"
    exit 1
fi

# Capture IP
ip="$1"
if [[ -z "$ip" ]]; then
    read -p "Enter PS5 IP address: " ip
fi

# Capture ELF loader port
port="$2";
if [[ -z "$port" ]]; then
    read -p "Enter PS5 elf loader port: " port
fi

# Capture firmware version
fwVersion="$3"
if [[ -z "$fwVersion" ]]; then
    read -p "Enter PS5 firmware version: " fwVersion
fi

# Lookup ALLPROC offset from known fw versions, fallback to user input where necessary
allproc="$(jq -r --arg key "$fwVersion" '.[$key]' /kstuff/src/allproc.json)"
if [[ -z "$allproc" ]] || [[ "$allproc" == "null" ]]; then
    echo "Error: Failed to find ALLPROC offset for firmware version ${fwVersion}"
    read -p "Enter ALLPROC offset (decimal): " allproc
fi

# Output determined execution vars
echo "> Preparing execution"
echo "IP: ${ip}"
echo "Port: ${port}"
echo "Firmware Version: ${fwVersion}"
echo "ALLPROC Offset: ${allproc}"

# Write symbols file in preparation for tool execution
if [[ ! -d /kstuff/results ]]; then
    mkdir -p /kstuff/results
fi
cat <<EOT > /kstuff/results/symbols.json
{
    "allproc": $allproc
}
EOT

# Execute the porting tool, if it fails so does this script
set -e
cd /kstuff/tool/ps5-kstuff/porting_tool
python3 main.py \
    /kstuff/results/symbols.json \
    $ip \
    $port \
    /kstuff/results/kernel-data.bin

# No failures (hopefully)
exit 0
