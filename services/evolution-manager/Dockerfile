FROM node:20-alpine

WORKDIR /app

# Install git and dependencies
RUN apk add --no-cache git

# Clone Evolution Manager
RUN git clone https://github.com/EvolutionAPI/evolution-manager.git .

# Install dependencies
RUN npm install

# Expose port
EXPOSE 3000

# Run in dev mode with host exposed
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
