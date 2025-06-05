# Build stage
FROM node:16-alpine AS build

WORKDIR /app

# Copy package files
COPY arbob-tech-erp-crm/package*.json ./

# Install dependencies including web-vitals
RUN npm install web-vitals --save && \
    npm install --legacy-peer-deps && \
    npm audit fix --force

# Copy the rest of the application
COPY arbob-tech-erp-crm/ .

# Set environment variables for build
ENV GENERATE_SOURCEMAP=false
ENV CI=false

# Build the application
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Add bash for debugging if needed
RUN apk add --no-cache bash

# Make sure files are owned by nginx
RUN chown -R nginx:nginx /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 