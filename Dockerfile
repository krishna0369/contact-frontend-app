# Use an official Node.js runtime as a parent image
FROM node:14-alpine AS builder

# Set the working directory in the container
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

# Use a smaller base image for the final stage
FROM nginx:alpine

# Copy the built Angular app from the builder stage
COPY --from=builder /app/dist/<your-angular-app-name> /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
