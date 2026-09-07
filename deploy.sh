#!/bin/bash

echo "Stopping Existing Containers..."

docker compose down

echo "Starting Containers..."

docker compose up -d

echo "Deployment Completed Successfully!"
