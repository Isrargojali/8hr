#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker if not installed
if ! command -v docker &> /dev/null; then
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
fi

# Install Docker Compose if not installed
if ! command -v docker-compose &> /dev/null; then
    sudo apt install -y docker-compose
fi

# Create project directory
mkdir -p ~/arbob-tech-erp
cd ~/arbob-tech-erp

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
    ports:
      - "5432:5432"
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

# Pull and start containers
docker-compose pull
docker-compose up -d

echo "Deployment completed! Check status with: docker-compose ps" 