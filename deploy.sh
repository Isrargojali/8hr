#!/bin/bash
set -e

echo "🔄 Starting deployment process..."

# Stop running containers
echo "Stopping existing containers..."
docker-compose -f docker-compose.new.yml down || true

# Remove old containers and images
echo "Cleaning up old containers and images..."
docker system prune -f

# Pull latest images
echo "Pulling latest images..."
docker pull israrahmad/arbob-tech-backend:latest
docker pull israrahmad/arbob-tech-frontend:latest

# Create necessary directories if they don't exist
echo "Setting up directories..."
mkdir -p /home/ubuntu/arbob-tech/data

# Start services
echo "Starting services..."
docker-compose -f docker-compose.new.yml up -d

echo "✅ Deployment completed!"
echo "Frontend: http://3.109.209.75"
echo "Backend: http://3.109.209.75:3000" 