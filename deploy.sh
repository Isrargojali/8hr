#!/bin/bash
set -e

echo "🔄 Starting deployment process..."

# Login to Docker Hub if credentials are provided
if [ ! -z "$DOCKER_USERNAME" ] && [ ! -z "$DOCKER_TOKEN" ]; then
    echo "Logging into Docker Hub..."
    echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin
fi

# Stop and remove existing containers
echo "Cleaning up existing containers..."
docker-compose -f docker-compose.new.yml down --remove-orphans || true
docker rm -f $(docker ps -aq) 2>/dev/null || true

# Remove existing images
echo "Removing old images..."
docker rmi -f $(docker images -q) 2>/dev/null || true

# Pull latest images
echo "Pulling latest images..."
docker-compose -f docker-compose.new.yml pull

# Start services
echo "Starting services..."
docker-compose -f docker-compose.new.yml up -d

# Wait for services to be healthy
echo "Waiting for services to be healthy..."
sleep 30

# Check if services are running
if ! docker ps | grep -q "arbob-backend-prod"; then
    echo "❌ Backend container failed to start"
    docker logs arbob-backend-prod
    exit 1
fi

if ! docker ps | grep -q "arbob-frontend-prod"; then
    echo "❌ Frontend container failed to start"
    docker logs arbob-frontend-prod
    exit 1
fi

echo "✅ Deployment completed!"
echo "Frontend: http://3.109.209.75"
echo "Backend: http://3.109.209.75:3000"

# Show container status and logs
echo "📝 Container Status:"
docker ps
echo "📝 Recent Logs:"
docker logs arbob-backend-prod --tail 50
docker logs arbob-frontend-prod --tail 50 