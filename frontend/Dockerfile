# Build stage
FROM node:16-alpine AS build

WORKDIR /app

# Copy package files
COPY arbob-tech-erp-crm/package*.json ./

# Install dependencies with specific flags to maintain essential packages
RUN npm install --legacy-peer-deps && \
    npm install web-vitals@3.5.0 --save && \
    npm install react-scripts@5.0.1 --save && \
    npm install @babel/plugin-proposal-private-property-in-object --save-dev

# Copy the rest of the application
COPY arbob-tech-erp-crm/ .

# Set environment variables for build
ENV GENERATE_SOURCEMAP=false
ENV CI=false
ENV NODE_ENV=production

# Build the application
RUN npm run build

# Production stage
FROM nginx:alpine

# Install necessary tools
RUN apk add --no-cache bash netcat-openbsd

# Create necessary directories
RUN mkdir -p /etc/nginx/conf.d

# Copy build files
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Make sure files are owned by nginx
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /etc/nginx/conf.d

# Create startup script
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"] 