#!/bin/bash

# Set default input file
DEFAULT_INPUT_FILE="hosts.txt"

# Use the provided argument or default to hosts.txt
INPUT_FILE="${1:-$DEFAULT_INPUT_FILE}"

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found."
    exit 1
fi

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Create a timestamped backup of the original /etc/hosts file
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
mkdir -p /etc/hosts_backups
cp /etc/hosts "/etc/hosts_backups/$TIMESTAMP"
echo "Original /etc/hosts backed up to /etc/hosts_backups/$TIMESTAMP"

# Add entries to /etc/hosts
while IFS= read -r domain
do
  # Skip empty lines and lines starting with #
  [[ -z "$domain" || "$domain" =~ ^#.*$ ]] && continue
  
  # Check if the domain is already in /etc/hosts
  if ! grep -q "127.0.0.1 $domain" /etc/hosts; then
    echo "127.0.0.1 $domain" >> /etc/hosts
    echo "Added: $domain"
  fi
done < "$INPUT_FILE"
echo "All new entries from '$INPUT_FILE' added to /etc/hosts"

# Flush DNS cache
dscacheutil -flushcache
killall -HUP mDNSResponder
echo "DNS cache flushed and mDNSResponder restarted"
