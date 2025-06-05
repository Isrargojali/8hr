#!/bin/bash

# Set the host URL for the deployment
export HOST_URL=http://3.109.209.75

# Stop any running containers
docker-compose down

# Remove old docker-compose.yml if it exists
rm -f docker-compose.yml

# Copy the new docker-compose file
cp docker-compose.new.yml docker-compose.yml

# Make sure nginx.conf exists in the current directory
if [ ! -f nginx.conf ]; then
    cp frontend/nginx.conf nginx.conf
fi

# Pull latest images
docker-compose pull

# Start services
docker-compose up -d

# Show status
docker-compose ps

# Wait for backend to be ready
echo "Waiting for backend to be ready..."
sleep 30

# Check backend logs for migration and seeding status
echo "Checking database migration and seeding status..."
docker-compose logs backend | grep -E "prisma|seed|Database is ready"

echo "Deployment completed. Your application should be accessible at:"
echo "Frontend: $HOST_URL"
echo "Backend: $HOST_URL:3000"
echo ""
echo "To view logs, run: docker-compose logs -f"
echo "To check database status again, run: docker-compose logs backend | grep -E 'prisma|seed|Database is ready'" 