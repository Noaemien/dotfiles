#!/bin/bash

# Check if ./linux directory exists
if [ ! -d "./macos" ]; then
    echo "Error: ./macos directory not found"
    exit 1
fi

# Iterate through all directories in ./linux
for dir in ./macos/*/ ; do
    # Check if it's actually a directory
    if [ -d "$dir" ]; then
        # Extract just the directory name
        dirname=$(basename "$dir")
        echo "Processing $dirname..."
        # Run stow command
        stow "$dirname" -d ./macos -t ~/ -v
    fi
done

echo "Done!"
