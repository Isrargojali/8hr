# Build and run stage
FROM node:16-alpine

WORKDIR /app

# Copy package files
COPY arbob-tech-erp-crm/package*.json ./

# Install dependencies with specific flags to maintain essential packages
RUN npm install --legacy-peer-deps && \
    npm install web-vitals@3.5.0 --save && \
    npm install react-scripts@5.0.1 --save && \
    npm install @babel/plugin-proposal-private-property-in-object --save-dev && \
    npm install serve -g

# Copy the rest of the application
COPY arbob-tech-erp-crm/ .

# Set environment variables for build
ENV GENERATE_SOURCEMAP=false
ENV CI=false
ENV NODE_ENV=production

# Build the application
RUN npm run build

EXPOSE 80

# Start static file server
CMD ["serve", "-s", "build", "-l", "80"] 