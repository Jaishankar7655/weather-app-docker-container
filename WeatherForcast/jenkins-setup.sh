#!/bin/bash

#=============================
# Full Cleanup + Jenkins Install Script
#=============================

set -e  # Exit if any command fails

echo "Step 1: Stop and remove all Docker containers..."
sudo docker stop $(sudo docker ps -q) 2>/dev/null || true
sudo docker rm $(sudo docker ps -a -q) 2>/dev/null || true

echo "Step 2: Remove all Docker images..."
sudo docker rmi -f $(sudo docker images -q) 2>/dev/null || true

echo "Step 3: Update system packages..."
sudo apt update -y
sudo apt upgrade -y

echo "Step 4: Install Java and dependencies..."
sudo apt install -y openjdk-11-jdk wget gnupg2 curl lsb-release

echo "Step 5: Add Jenkins key and repository..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Step 6: Update package list again..."
sudo apt update -y

echo "Step 7: Install Jenkins..."
sudo apt install -y jenkins

echo "Step 8: Fix Jenkins folder permissions..."
sudo chown -R jenkins:jenkins /var/lib/jenkins /var/log/jenkins /var/cache/jenkins

echo "Step 9: Check if port 8080 is free..."
if sudo lsof -i :8080 | grep LISTEN; then
    echo "Port 8080 is busy. Switching Jenkins to port 8081..."
    sudo sed -i 's/HTTP_PORT=8080/HTTP_PORT=8081/' /etc/default/jenkins
else
    echo "Port 8080 is free. Using default port."
fi

echo "Step 10: Start and enable Jenkins service..."
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl restart jenkins
sudo systemctl status jenkins --no-pager

echo "✅ Jenkins installation complete!"
echo "Access Jenkins at: http://<YOUR_SERVER_IP>:$(grep HTTP_PORT /etc/default/jenkins | cut -d '=' -f2)"

