#!/bin/sh

docker stop swagger || true
docker rm swagger || true
docker build -t $1/swagger .

echo
echo "=> To store as new base image: 'docker push $1/swagger'"
echo
