FROM node:18-alpine

WORKDIR /app

# Install dependencies required for Prisma
RUN apk add --no-cache openssl

# First copy only package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy prisma files and generate client
COPY prisma ./prisma/
RUN npx prisma generate

# Copy the rest of the application
COPY . .

# Create a simple startup script
RUN echo '#!/bin/sh\n\
npx prisma migrate deploy\n\
npx prisma db seed\n\
npm start' > /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 3000

CMD ["/docker-entrypoint.sh"] 