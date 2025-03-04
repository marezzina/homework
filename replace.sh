latest_version="1.27.4"
VER_TO_BE_REPLACED=$(cat Dockerfile | grep FROM | awk -F: '{print $2}')
sed -i "s/$VER_TO_BE_REPLACED/$latest_version/g" Dockerfile
