# Use Ubuntu as the base image
FROM ubuntu:latest

# Update apt-get package list and install nginx
RUN apt-get update && apt-get install -y nginx

# Copy the web application files to the default Nginx document root
COPY index.html /var/www/html/

# Expose port 80 for web traffic
EXPOSE 80

# Start nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
