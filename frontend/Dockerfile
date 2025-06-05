# Build stage
FROM node:16-alpine AS build

WORKDIR /app
COPY ./arbob-tech-erp-crm/package*.json ./
RUN npm install
COPY ./arbob-tech-erp-crm/ .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Add bash for debugging if needed
RUN apk add --no-cache bash

# Make sure files are owned by nginx
RUN chown -R nginx:nginx /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 