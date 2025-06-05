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

# Copy build files and nginx configuration
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Add bash for debugging if needed
RUN apk add --no-cache bash

# Make sure files are owned by nginx
RUN chown -R nginx:nginx /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 