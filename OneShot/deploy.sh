#!/bin/bash

# Function definitions (define ONCE)

code_clone() {
    echo "Cloning/Checking code directory..."
    if [ ! -d "django-notes-app" ]; then
        git clone https://github.com/LondheShubham153/django-notes-app.git
        if [ $? -ne 0 ]; then  # Check git clone status
            echo "Git clone failed."
            return 1
        fi
        echo "Cloning complete."
    else
        echo "Code directory exists. Skipping clone."
    fi
    cd django-notes-app
    pwd
    ls -l  # List files (long format for details)
    return 0
}

install_requirements() {
    echo "Installing/Checking system dependencies..."
    # Install Docker and Nginx (only if they aren't installed)
    if ! command -v docker &> /dev/null; then  # Check if docker is installed
        sudo dnf install docker-ce -y
        if [ $? -ne 0 ]; then
            echo "Docker installation failed."
            return 1
        fi
    fi

    if ! command -v nginx &> /dev/null; then # Check if nginx is installed
        sudo dnf install nginx -y
        if [ $? -ne 0 ]; then
            echo "Nginx installation failed."
            return 1
        fi
    fi

    echo "System dependencies checked/installed."
    return 0
}

require_restarts() {
    echo "Starting/Restarting services..."
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo systemctl enable nginx
    sudo systemctl start nginx
    sudo systemctl status docker | grep "Active"
    sudo systemctl status nginx | grep "Active"
    sudo docker ps
    echo "Services started/restarted."
    return 0
}


deploy() {
    echo "Building and starting containers..."
    sudo docker compose up -d --build
    if [ $? -ne 0 ]; then
        echo "Docker compose up failed."
        return 1
    fi
    return 0
}


# Main script logic

echo "******DEPLOYMENT STARTED******"

if ! code_clone; then
    exit 1
fi

if ! install_requirements; then
    exit 1
fi

if ! require_restarts; then
    exit 1
fi

if ! deploy; then
    echo "******DEPLOYMENT FAILED******"
    exit 1
fi

echo "******DEPLOYMENT DONE******"
