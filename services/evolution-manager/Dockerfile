FROM node:20-alpine

WORKDIR /app

# Install git and dependencies
RUN apk add --no-cache git

# Clone Evolution Manager
RUN git clone https://github.com/EvolutionAPI/evolution-manager.git .

# Install dependencies (this is what's missing in published images)
RUN npm install

# Build arguments for Vite
ARG VITE_API_URL=http://18.207.71.231:8080
ARG VITE_API_KEY=CHANGE_THIS_API_KEY

# Set as env vars for build
ENV VITE_API_URL=$VITE_API_URL
ENV VITE_API_KEY=$VITE_API_KEY

# Build the app with env vars baked in
RUN npm run build

# Expose port
EXPOSE 3000

# Serve the built app
CMD ["npx", "serve", "-s", "dist", "-l", "3000"]
