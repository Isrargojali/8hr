FROM node:18-alpine AS dependencies

WORKDIR /app

# Copy package files
COPY arbob-tech-erp-crm/package*.json ./

# Install dependencies including web-vitals
RUN npm install web-vitals --save && \
    npm install --production=false

# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy node_modules from dependencies stage
COPY --from=dependencies /app/node_modules ./node_modules

# Copy the rest of the application
COPY arbob-tech-erp-crm/ .

# Set environment variables for build
ENV GENERATE_SOURCEMAP=false
ENV CI=false

# Build the application
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built assets from builder stage
COPY --from=builder /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Optimize nginx
RUN rm -rf /usr/share/nginx/html/static/js/*.map

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 