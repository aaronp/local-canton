#!/bin/bash

echo "Starting Canton network..."

# Start the Canton network
docker-compose up -d

# Wait for Canton to be ready
echo "Waiting for Canton to be ready..."
timeout=60
counter=0
while [ $counter -lt $timeout ]; do
    if docker exec canton-local curl -s http://localhost:7575/health >/dev/null 2>&1; then
        echo "Canton is ready!"
        break
    fi
    sleep 2
    counter=$((counter + 2))
done

if [ $counter -ge $timeout ]; then
    echo "Timeout waiting for Canton to be ready"
    exit 1
fi

# Bootstrap is now handled by the daemon startup
echo "Canton network bootstrapped during startup"

echo "Canton network is running!"
echo "Available endpoints:"
echo "  - Domain public API: http://localhost:5011"
echo "  - Participant 1 ledger API: http://localhost:5021"
echo "  - Participant 2 ledger API: http://localhost:5031"
echo ""
echo "To deploy the DAML contract, run: ./deploy-contract.sh"