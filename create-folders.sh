#!/bin/bash

# Function to generate a unique name using POSIX timestamp
generate_unique_name() {
    echo $(date +%s%N)
}

echo "Enter the path where you want to create the folders:"
read path
if [ ! -d $path ]; then
    mkdir -p $path
    cd $path
    # Generate a random number of folders between 9 and 11
    num_folders=$((RANDOM % 3 + 9))

    for ((i = 0; i < num_folders; i++)); do
        # Create a unique folder name
        folder_name=$(generate_unique_name)
        mkdir "$folder_name"

        # Randomly decide whether to create subfolders
        if ((RANDOM % 2)); then
            # Generate a random number of subfolders between 2 and 4
            num_subfolders=$((RANDOM % 3 + 2))

            for ((j = 0; j < num_subfolders; j++)); do
                # Create a unique subfolder name
                subfolder_name=$(generate_unique_name)
                mkdir "$folder_name/$subfolder_name"

                # Randomly decide whether to create a txt file in the subfolder
                if ((RANDOM % 2)); then
                    txt_file_name="$folder_name/$subfolder_name/$(generate_unique_name).txt"
                    echo "bzbz text" >"$txt_file_name"
                fi
            done
        fi
    done

    echo "Folders and subfolders created successfully."

else
    echo "Path does not exist"
    exit 1
fi
