# Use the official Nginx image from the Docker Hub
FROM nginx:1.20-alpine

# Copy static website files to the Nginx web root directory
COPY . /usr/share/nginx/html

