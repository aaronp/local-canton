#!/bin/bash

if [ ! -f "./bin/canton" ]; then
    echo "Canton not found. Please run ./setup-local.sh first."
    exit 1
fi

echo "Starting Canton network..."

# Start Canton daemon in background
nohup ./bin/canton daemon --config ./canton-config/canton.conf --log-level-canton=INFO --bootstrap ./canton-config/bootstrap.canton > ./log/canton.out 2>&1 &
CANTON_PID=$!
echo "Canton started with PID: $CANTON_PID"

# Wait a bit for Canton to start
sleep 5

echo "Canton network started!"
echo "Available endpoints:"
echo "  - Domain public API: http://localhost:5011"
echo "  - Participant 1 ledger API: http://localhost:5021"
echo "  - Participant 2 ledger API: http://localhost:5031"