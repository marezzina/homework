#!bin/.bash

# Function to list empty folders
list_empty_folders() {
    find "$1" -type d -empty
}

# Function to delete empty folders
delete_empty_folders() {
    find "$1" -type d -empty -delete
}

read -p "Enter the path to check for empty folders: " input_path
empty_folders=$(list_empty_folders "$input_path")

if [ -z "$empty_folders" ]; then
    echo "No empty folders found."
else
    echo "Empty folders found:"
    echo "$empty_folders"

    # Ask the user if they want to delete the empty folders
    read -p "Do you want to delete all empty folders? (y/n): " user_choice

    if [ "$user_choice" == "y" ]; then
        delete_empty_folders "$input_path"
        echo "All empty folders have been deleted."
    else
        echo "No folders were deleted."
    fi
fi
