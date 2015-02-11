#!/bin/sh

docker stop telescope || true
docker rm telescope || true
docker build -t $1/telescope .

echo
echo "=> To store as new base image: 'docker push $1/telescope'"
echo
