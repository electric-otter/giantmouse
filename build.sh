#!/bin/bash

# Move up one directory safely
cd .. || { echo "Failed to move up a directory"; exit 1; }

# Get the filename from the user
read -p "Enter the file name to use: " filename

# Check if the file exists
if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' not found!"
    exit 1
fi

# Make the file executable
chmod +x "$filename"

# Ask user if they want to view the file
read -p "Do you want to view the file contents? (y/n): " viewfile
if [[ "$viewfile" == "y" ]]; then
    cat "$filename"
fi

echo "Debug your script!"
set -x  # Enable debug mode
bash "$filename"  # Execute the script

# Install shc if not installed
if ! command -v shc &>/dev/null; then
    echo "Installing shc..."
    sudo apt install -y shc
fi

# Ask user for output filename
read -p "Enter output file name (without extension): " outputname

# Compile the script using shc
shc -f "$filename" -o "$outputname"

echo "Script compiled successfully as $outputname"
