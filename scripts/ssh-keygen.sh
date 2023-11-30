#!/bin/bash

# Prompt for the key name
read -p "Enter desired key name (default: id_rsa): " key_name
key_name=${key_name:-id_rsa}

# Prompt for the directory (default: ~/.ssh/)
read -p "Enter the directory for key to be saved (default: ~/.ssh/): " directory
directory=${directory:-~/.ssh/}

# Expand the tilda in the directory path
directory=$(eval echo "$directory")

# Ensure the directory exists
mkdir -p "$directory"

# Generate the SSH key pair
ssh-keygen -t rsa -b 2048 -f "$directory/$key_name"


# Print output of name and location of the key
echo "SSH key pair generated:"
echo "Private key: $directory/$key_name"
echo "Public key: $directory/$key_name.pub"