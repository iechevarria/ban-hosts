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

sort -u -o "$INPUT_FILE" "$INPUT_FILE"
echo "Input hosts file '$INPUT_FILE' sorted and duplicates removed."
