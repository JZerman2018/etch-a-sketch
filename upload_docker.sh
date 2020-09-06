#!/usr/bin/env bash
# This will upload an image to Docker Hub after using run_docker.sh

#Step 1:
# Create dockerpath
# # dockerpath=<your docker ID/path>
dockerpath="jzerman2018/devopscapstone"

#Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
#docker login --username jzerman2018
docker image tag devopscapstone $dockerpath:latest

# Step 3:
# Push image to a docker repository
docker push $dockerpath:latest