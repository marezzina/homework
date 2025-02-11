#!bin/.bash

# get input from cmd
echo "Enter the name of the folder you would like to delete: "
read folderName && echo "$(realpath $folderName) "

# delete the folder/files
if [ -d $folderName ]; then
    echo "Folder $(realpath $folderName) exists...deleting"
    rm -r $folderName
    echo "Folder has been deleted"
    exit 0
else
    echo "Folder does not exist"
    exit 1
fi
