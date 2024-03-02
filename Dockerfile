# Use an official Node.js runtime as the base image
FROM node:20.11.1 AS build

# Set the working directory within the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Build the Angular app for production
RUN npm run build

# Use NGINX as the base image for serving the Angular app
FROM nginx:alpine

# Copy the built Angular app from the previous stage to NGINX's html directory
COPY --from=build /app/dist/swathi-app/browser /usr/share/nginx/html/

# Expose port 80 to the outside world
EXPOSE 80

# Command to run NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]
