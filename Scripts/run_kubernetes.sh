#!/usr/bin/env bash

# Step 1:
# /home/ubuntu/.local/bin/aws eks --region us-east-1 update-kubeconfig --name devopscapstone-cluster
# Dockerpath ID
dockerpath="jzerman2018/devopscapstone"



# Step 2
# Run the Docker Hub container with kubernetes for deployment
kubectl apply -f deployment.yml
kubectl get nodes
kubectl get deployments

# Step 3:
# List kubernetes pods
kubectl get pod -o wide


# Step 4:
# Forward the container port to a host
kubectl expose deployment devopscapstone --type=LoadBalancer --port=80
kubectl get svc