# Stage 1: Build Angular application
FROM node:14 AS builder

WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install project dependencies
RUN npm install

# Copy the entire application code to the container
COPY . .

# Build the Angular app for production
RUN ng build --prod

# Stage 2: Create a lightweight container with Nginx to serve the Angular app
FROM nginx:latest

# Copy the built Angular app from the builder stage
COPY --from=build /usr/local/app/dist/* /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
