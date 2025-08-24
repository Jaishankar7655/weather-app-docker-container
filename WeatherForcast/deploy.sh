#!/bin/bash

# Update package list
sudo apt update -y

# Install Docker
sudo apt install docker.io -y

# Add user to docker group (requires logout/login or newgrp to take effect)
sudo usermod -aG docker $USER

# Install Docker Compose
sudo apt install docker-compose -y

# Note: You need to logout and login again, or run 'newgrp docker' 
# for the group membership to take effect
echo "Please logout and login again, or run 'newgrp docker' to apply group changes"

# Make sure docker-compose.yml exists and has proper permissions
if [ -f "./docker-compose.yml" ]; then
    echo "docker-compose.yml found"
    # docker-compose.yml should be readable, not executable
    chmod 644 ./docker-compose.yml
else
    echo "Error: docker-compose.yml not found in current directory"
    exit 1
fi

# Start Docker service (if not already running)
sudo systemctl start docker
sudo systemctl enable docker

# Build and run the containers
docker-compose up -d --build

# Check container status
docker ps -a

# Check logs (replace 'weather-app' with your actual container name)
echo "Checking logs for weather-app container:"


# Additional useful commands:
echo "Useful commands:"
echo "- Stop containers: docker-compose down"
echo "- View logs: docker logs <container-name>"
echo "- Restart containers: docker-compose restart"