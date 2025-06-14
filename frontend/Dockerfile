FROM node:18-alpine as builder

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Set build time arguments
ARG REACT_APP_API_URL
ARG REACT_APP_BASE_URL
ARG REACT_APP_API_BASE_URL
ARG REACT_APP_BACKEND_URL
ARG PUBLIC_URL

# Set environment variables
ENV REACT_APP_API_URL=${REACT_APP_API_URL}
ENV REACT_APP_BASE_URL=${REACT_APP_BASE_URL}
ENV REACT_APP_API_BASE_URL=${REACT_APP_API_BASE_URL}
ENV REACT_APP_BACKEND_URL=${REACT_APP_BACKEND_URL}
ENV PUBLIC_URL=${PUBLIC_URL}

# Build the application
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy the build output
COPY --from=builder /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 