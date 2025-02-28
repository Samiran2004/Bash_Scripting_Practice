#!/bin/bash

<< task
Deploy a Django app and handle the errors
task

function code_clone() {
    echo "Cloning the Django app...."
    git clone https://github.com/LondheShubham153/django-notes-app.git
}

function install_requirements() {
    echo "Installing dependencies..."
    sudo dnf update -y
    
    # Install Docker with proper package name
    if command -v dnf &> /dev/null; then
        # For Fedora/RHEL
        sudo dnf install -y docker-ce docker-ce-cli containerd.io nginx
    elif command -v apt-get &> /dev/null; then
        # For Ubuntu/Debian
        sudo apt-get update
        sudo apt-get install -y docker.io nginx
    else
        echo "Unsupported package manager. Please install Docker manually."
        return 1
    fi
}

function check_nginx_config() {
    echo "Checking Nginx configuration..."
    sudo nginx -t
    if [ $? -ne 0 ]; then
        echo "Nginx configuration test failed. Fixing default configuration..."
        # Create a minimal working configuration
        cat << EOF | sudo tee /etc/nginx/nginx.conf
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
}
EOF
        # Make sure the required directories exist
        sudo mkdir -p /etc/nginx/conf.d /etc/nginx/default.d /usr/share/nginx/html /var/log/nginx
        sudo chown -R nginx:nginx /var/log/nginx
        
        # Create a basic index file
        echo "Welcome to Nginx!" | sudo tee /usr/share/nginx/html/index.html
        
        # Test again
        sudo nginx -t
        if [ $? -ne 0 ]; then
            echo "Could not fix Nginx configuration automatically. Manual intervention required."
            return 1
        fi
    fi
    return 0
}

function required_restart() {
    echo "Enabling and starting services..."
    sudo systemctl enable docker
    sudo systemctl start docker || { echo "Failed to start Docker"; return 1; }
    
    # First check and fix Nginx config
    check_nginx_config || return 1
    
    sudo systemctl enable nginx
    sudo systemctl start nginx || { echo "Failed to start Nginx. Check logs with: journalctl -xeu nginx.service"; return 1; }
    
    return 0
}

function deploy() {
    echo "Building and deploying the application..."
    # Make sure we're in the right directory
    cd django-notes-app || return
    
    # Check if Dockerfile exists
    if [ ! -f "Dockerfile" ]; then
        echo "Dockerfile not found. Creating a basic Dockerfile..."
        cat << EOF > Dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
EOF
    fi
    
    # Build the Docker image with proper syntax
    sudo docker build -t notes-app .
    
    # Stop any existing container with the same name
    sudo docker stop notes-container 2>/dev/null || true
    sudo docker rm notes-container 2>/dev/null || true
    
    # Run the new container
    sudo docker run -d --name notes-container -p 8000:8000 notes-app:latest
    
    # Configure Nginx to proxy to the application
    cat << EOF | sudo tee /etc/nginx/conf.d/notes-app.conf
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF
    
    # Restart Nginx to apply changes
    sudo systemctl restart nginx
    if [ $? -ne 0 ]; then
        echo "Failed to restart Nginx after configuration. Checking logs..."
        sudo journalctl -xeu nginx.service
        return 1
    fi
    
    echo "Application deployed and available at http://localhost"
}

echo "**********DEPLOYMENT STARTED***********"

# Check if the directory exists
if [ -d "django-notes-app" ]; then
    echo "The code dir already exists"
    cd django-notes-app || exit
    echo "Dir changed.."
    # Optional: Update the code
    git pull
else
    # Clone if it doesn't exist
    code_clone || exit 1
    cd django-notes-app || exit
fi

install_requirements || exit 1
required_restart || exit 1
deploy || exit 1

echo "**********DEPLOYMENT DONE***********"