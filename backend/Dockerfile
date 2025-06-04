FROM node:18-alpine

WORKDIR /app

# Install dependencies required for Prisma and wait-for-it script
RUN apk add --no-cache openssl bash netcat-openbsd

COPY package*.json ./
COPY prisma ./prisma/

RUN npm install

COPY . .

RUN npx prisma generate

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