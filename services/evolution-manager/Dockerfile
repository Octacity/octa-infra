FROM node:20-alpine

WORKDIR /app

# Install git and dependencies
RUN apk add --no-cache git

# Clone Evolution Manager
RUN git clone https://github.com/EvolutionAPI/evolution-manager.git .

# Install dependencies (this is what's missing in published images)
RUN npm install

# Build the application
RUN npm run build

# Expose port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
