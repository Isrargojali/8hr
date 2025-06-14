#!/bin/bash
set -e

echo "🔄 Starting deployment process..."

# Stop and remove existing containers
echo "Cleaning up existing containers..."
docker-compose -f docker-compose.new.yml down --remove-orphans
docker rm -f $(docker ps -aq) || true

# Remove existing images
echo "Removing old images..."
docker rmi -f $(docker images -q) || true

# Pull latest images
echo "Pulling latest images..."
docker pull israrahmad/arbob-tech-backend:latest
docker pull israrahmad/arbob-tech-frontend:latest

# Start services
echo "Starting services..."
docker-compose -f docker-compose.new.yml up -d

echo "✅ Deployment completed!"
echo "Frontend: http://3.109.209.75"
echo "Backend: http://3.109.209.75:3000"

# Show logs
echo "📝 Container Status:"
docker ps 