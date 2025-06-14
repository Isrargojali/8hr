#!/bin/bash
set -e

echo "🔄 Starting deployment process..."

# Stop and remove all containers
echo "Stopping and removing all containers..."
docker-compose -f docker-compose.new.yml down --remove-orphans
docker rm -f $(docker ps -aq) || true

# Remove all images
echo "Removing all images..."
docker rmi -f $(docker images -q) || true

# Pull latest images
echo "Pulling latest images..."
docker pull israrahmad/arbob-tech-backend:latest
docker pull israrahmad/arbob-tech-frontend:latest

# Start postgres first
echo "Starting PostgreSQL..."
docker-compose -f docker-compose.new.yml up -d postgres
sleep 10

# Start backend
echo "Starting Backend..."
docker-compose -f docker-compose.new.yml up -d backend
sleep 10

# Start frontend
echo "Starting Frontend..."
docker-compose -f docker-compose.new.yml up -d frontend

echo "✅ Deployment completed!"
echo "Frontend: http://3.109.209.75"
echo "Backend: http://3.109.209.75:3000"

# Show logs
echo "📝 Backend Logs:"
docker logs arbob-backend-prod 