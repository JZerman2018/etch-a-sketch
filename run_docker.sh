#!/usr/bin/env bash

# Step 1:
# Build image and add a descriptive tag
docker build -t devopscapstone .

#Step 2:
# List Docker images
docker images ls

#Step 3:
# Run app
docker run -d -p 8000:8000 devopscapstone