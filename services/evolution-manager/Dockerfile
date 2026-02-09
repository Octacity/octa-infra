FROM node:20-alpine AS builder

WORKDIR /app

# Install git
RUN apk add --no-cache git

# Clone Evolution Manager
RUN git clone https://github.com/EvolutionAPI/evolution-manager.git .

# Install dependencies
RUN npm install

# Build for production
RUN npm run build

# Production stage
FROM node:20-alpine

WORKDIR /app

# Install serve to host the static files
RUN npm install -g serve

# Copy built files from builder
COPY --from=builder /app/dist ./dist

# Expose port
EXPOSE 3000

# Serve the production build
CMD ["serve", "-s", "dist", "-l", "3000"]
