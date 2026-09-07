#!/bin/bash

echo "Building Docker Image..."

docker build -t react-app:v1 .

echo "Build Completed Successfully!"
