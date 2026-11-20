
# Use Node.js as the base environment
FROM node:22-alpine

# Set the working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install project dependencies
RUN npm ci

# Copy the application source code
COPY . .

# Build the Next.js application
RUN npm run build

# Set production environment
ENV NODE_ENV=production

# Expose application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
