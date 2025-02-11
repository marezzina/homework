#!/bin/bash

# Function to generate file tree
generate_file_tree() {
    local input_path="$1"

    if [ -d "$input_path" ]; then
        echo "File tree for $input_path:"
        tree "$input_path"
    else
        echo "The specified path is not a directory."
    fi
}

# Get the input path from the user
read -p "Enter the path to generate the file tree: " input_path

# Call the function with the user input
generate_file_tree "$input_path"
