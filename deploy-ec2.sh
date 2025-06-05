#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker if not installed
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
fi

# Install Docker Compose if not installed
if ! command -v docker-compose &> /dev/null; then
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Create project directory
mkdir -p ~/arbob-tech-erp
cd ~/arbob-tech-erp

# Pull the latest images
docker pull israrahmad/arbob-tech-frontend:latest
docker pull israrahmad/arbob-tech-backend:latest

# Create docker-compose.yml
cat > docker-compose.yml << 'EOL'
version: '3.8'

services:
  postgres:
    image: postgres:latest
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: israr123
      POSTGRES_DB: Arbob
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: always

  backend:
    image: israrahmad/arbob-tech-backend:latest
    environment:
      DATABASE_URL: postgresql://postgres:israr123@postgres:5432/Arbob
      JWT_SECRET: your_jwt_secret_here
      NODE_ENV: production
    depends_on:
      - postgres
    ports:
      - "3000:3000"
    restart: always

  frontend:
    image: israrahmad/arbob-tech-frontend:latest
    ports:
      - "80:80"
    depends_on:
      - backend
    restart: always

volumes:
  postgres_data:
EOL

# Start the containers
docker-compose up -d

echo "Deployment completed! Your application should be running at http://3.109.209.75" 