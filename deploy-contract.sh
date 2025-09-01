#!/bin/bash

echo "Building and deploying DAML contract..."

# Build the DAML contract
cd daml
echo "Building DAML project..."
daml build

if [ $? -ne 0 ]; then
    echo "Failed to build DAML project"
    exit 1
fi

echo "Contract built successfully!"

# Deploy to Canton participant 1
echo "Deploying contract to Canton participant 1..."
daml ledger upload-dar --host localhost --port 5021 .daml/dist/simple-contract-1.0.0.dar

if [ $? -ne 0 ]; then
    echo "Failed to deploy contract"
    exit 1
fi

echo "Contract deployed successfully!"

# Run the test script
echo "Running test script..."
daml script --dar .daml/dist/simple-contract-1.0.0.dar --script-name SimpleContract:testAsset --ledger-host localhost --ledger-port 5021

echo "Test completed! Check the Canton logs for transaction details."