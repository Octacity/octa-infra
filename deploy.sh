#!/bin/bash
set -e

echo "🚀 Deploying Octa services..."

# Navigate to services directory
cd /opt/octa-infra/services

# Deploy each service
for service in dockge beszel dozzle evolution-api; do
    echo "📦 Deploying $service..."
    cd $service
    docker-compose pull
    docker-compose up -d
    cd ..
done

echo "✅ All services deployed successfully!"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
