#!/bin/sh
set -e

# Maximum number of attempts to connect to postgres
MAX_ATTEMPTS=30
ATTEMPT=1

echo "🔄 Starting backend service..."

echo "⏳ Waiting for postgres..."
while ! pg_isready -h postgres -p 5432 -U postgres; do
    if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
        echo "❌ Failed to connect to postgres after $MAX_ATTEMPTS attempts"
        exit 1
    fi
    echo "Attempt $ATTEMPT of $MAX_ATTEMPTS: Postgres is not ready yet..."
    ATTEMPT=$((ATTEMPT+1))
    sleep 2
done
echo "✅ PostgreSQL is ready!"

echo "⏳ Running database migrations..."
npx prisma migrate deploy
echo "✅ Migrations completed!"

echo "⏳ Running database seed..."
npx prisma db seed
echo "✅ Seeding completed!"

echo "🚀 Starting the application..."
exec npm start 