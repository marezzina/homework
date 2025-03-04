get_current_nginx_version() {
    docker exec -it my-nginx nginx -v 2>&1 | grep -oP '(?<=nginx/)[0-9]+\.[0-9]+\.[0-9]+'
}

get_latest_nginx_version() {
    curl -s https://registry.hub.docker.com/v2/repositories/library/nginx/tags |
        jq -r '.results[].name' | grep -oP '[0-9]+\.[0-9]+\.[0-9]' | sort -V | tail -n 1
}

latest_version=$(get_latest_nginx_version)
current_version=$(get_current_nginx_version)

echo "cur=$current_version lts=$latest_version"

# Compare versions and prompt for update if a newer version is available
if [ "$latest_version" != "$current_version" ]; then
    read -p "A newer version of Nginx is available. Do you want to update and restart? (y/n): " answer
    if [ "$answer" == "y" ]; then
        docker pull nginx:$latest_version
        docker stop my-nginx
        docker rm my-nginx
        docker rmi my-nginx-image
        VER_TO_BE_REPLACED=$(cat Dockerfile | grep FROM | awk -F: '{print $2}')
        sed -i "s/$VER_TO_BE_REPLACED/$latest_version/g" Dockerfile
        docker build -t my-nginx-image .
        docker run -d --name my-nginx -p 8080:80 my-nginx-image:latest
        echo "Nginx has been updated to version $latest_version and restarted."
    else
        echo "Update canceled."
    fi
else
    echo "Nginx is already up to date."
fi
