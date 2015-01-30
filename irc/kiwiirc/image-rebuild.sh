#!/bin/bash
set -e

docker stop kiwiirc || true
docker rm kiwiirc || true
docker build -t $1/kiwiirc .

echo
echo "=> To store as new base image: 'docker push $1/kiwiirc'"
echo
