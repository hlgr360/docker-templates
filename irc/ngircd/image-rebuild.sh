#!/bin/bash
set -e

docker stop ngircd || true
docker rm ngircd || true
docker build -t $1/ngircd .

echo
echo "=> To store as new base image: 'docker push $1/ngircd'"
echo
