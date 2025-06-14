FROM node:18-alpine

WORKDIR /app

# Install OpenSSL and other required dependencies
RUN apk add --no-cache openssl openssl-dev && \
    apk add --no-cache libc6-compat && \
    apk add --no-cache libssl3

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy prisma files and generate client
COPY prisma ./prisma/
RUN npx prisma generate

# Copy the rest of the application
COPY . .

# Set default environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV HOST=0.0.0.0
ENV DATABASE_URL=postgresql://postgres:israr123@postgres:5432/Arbob?schema=public
ENV JWT_SECRET=hello123hdjmaKJGVSFFSKHKHSK
ENV HOST_URL=http://3.109.209.75:3000
ENV CORS_ORIGIN=http://3.109.209.75
ENV API_URL=http://3.109.209.75:3000/api

EXPOSE 3000

# Generate Prisma client, run migrations, and start the application
CMD ["sh", "-c", "npx prisma generate && npx prisma migrate deploy && npm start"] 