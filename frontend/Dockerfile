FROM node:18-alpine as dependencies

WORKDIR /app

# Copy only package files first
COPY arbob-tech-erp-crm/package*.json ./

# Install dependencies with clean npm cache
RUN npm cache clean --force && \
    npm install --production=false

# Build stage
FROM node:18-alpine as builder

WORKDIR /app

# Increase Node.js memory limit and set production mode
ENV NODE_OPTIONS="--max-old-space-size=2048" \
    NODE_ENV=production \
    CI=false

# Copy dependencies from previous stage
COPY --from=dependencies /app/node_modules ./node_modules
COPY arbob-tech-erp-crm/ .

# Build with reduced memory usage
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built assets and config
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Optimize nginx
RUN rm -rf /usr/share/nginx/html/static/js/*.map

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 