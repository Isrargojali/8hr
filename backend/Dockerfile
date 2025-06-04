FROM node:18-alpine

WORKDIR /app

# Install dependencies required for Prisma and wait-for-it script
RUN apk add --no-cache openssl bash netcat-openbsd

# First copy only package files and install dependencies
COPY package*.json ./

# Clean npm cache and install dependencies with clean npm cache
RUN npm cache clean --force && \
    npm install --production=false --no-package-lock

# Copy prisma files and generate client
COPY prisma ./prisma/
RUN npx prisma generate

# Copy the rest of the application
COPY . .

EXPOSE 3000

# Create a startup script
COPY <<EOF /docker-entrypoint.sh
#!/bin/bash
set -e

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
while ! nc -z postgres 5432; do
  sleep 1
done
echo "PostgreSQL is ready!"

# Run migrations
echo "Running database migrations..."
npx prisma migrate deploy

# Run seed
echo "Running database seed..."
npx prisma db seed

# Start the application
echo "Starting the application..."
npm start
EOF

RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"] 