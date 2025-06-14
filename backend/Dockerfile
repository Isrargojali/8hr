FROM node:18-alpine

WORKDIR /app

# Install OpenSSL and other required dependencies
RUN apk add --no-cache openssl openssl-dev \
    && apk add --no-cache libc6-compat \
    && apk add --no-cache libssl1.1

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy prisma files and generate client
COPY prisma ./prisma/
RUN npx prisma generate

# Copy the rest of the application
COPY . .

EXPOSE 3000

ENV NODE_ENV=production
ENV PORT=3000

# Generate Prisma client and start the application
CMD ["sh", "-c", "npx prisma generate && npm start"] 