# Local Canton

This project demonstrates how to spin up a local Canton network and deploy a simple DAML contract.

## Prerequisites

- DAML SDK (install from https://docs.daml.com/getting-started/installation.html)
- Java 17 or later
- curl (for downloading Canton)

## Quick Start

### Option 1: Local Installation (Recommended)

1. Set up Canton locally:
   ```bash
   ./setup-local.sh
   ```

2. Start the Canton network:
   ```bash
   ./start-local-canton.sh
   ```

### Option 2: Docker (if you have access to Canton images)

1. Start the Canton network:
   ```bash
   ./start-canton.sh
   ```

2. Deploy and test the sample contract:
   ```bash
   ./deploy-contract.sh
   ```

3. Stop the Canton network:
   ```bash
   ./stop-canton.sh
   ```

## What's Included

- **Docker Compose setup**: Runs Canton with domain and two participants
- **Simple DAML contract**: An Asset contract with transfer functionality
- **Bootstrap script**: Automatically connects participants to the domain
- **Test script**: Demonstrates contract deployment and execution

## Network Endpoints

- Domain public API: http://localhost:5011
- Participant 1 ledger API: http://localhost:5021
- Participant 2 ledger API: http://localhost:5031

## File Structure

- `docker-compose.yml` - Docker Compose configuration
- `canton-config/` - Canton configuration files
- `daml/` - DAML contract source code
- `start-canton.sh` - Start script
- `deploy-contract.sh` - Contract deployment script
- `stop-canton.sh` - Stop script

