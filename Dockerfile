# Base image
FROM node:16-alpine

# Set working directory inside the container
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all source code
COPY . .

# Expose port 3000 for the app
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
