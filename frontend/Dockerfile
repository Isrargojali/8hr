FROM node:18-alpine as build

WORKDIR /app

# Increase Node.js memory limit
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Copy package files
COPY arbob-tech-erp-crm/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY arbob-tech-erp-crm/ .

# Set CI environment variable to false to prevent treating warnings as errors
ENV CI=false

# Build the application
RUN npm run build

# Production environment
FROM nginx:alpine

# Copy built assets from builder
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 