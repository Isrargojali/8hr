#!/bin/sh
set -e

# Wait for backend to be ready
echo "Waiting for backend..."
while ! nc -z arbob-backend-prod 3000; do
    sleep 1
done
echo "Backend is up!"

# Start nginx
echo "Starting nginx..."
exec nginx -g 'daemon off;' 