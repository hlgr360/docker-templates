#!/bin/bash
docker stop rails
docker rm rails
docker build -t <your-repo>/rails /app

echo
echo "=> To store as new base image: 'docker push <your-repo>/rails'"
echo
