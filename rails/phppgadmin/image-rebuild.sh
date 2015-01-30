#!/bin/bash
set -e

docker stop phppgadmin || true
docker rm phppgadmin || true
docker build -t $1/phppgadmin .

echo
echo "=> To store as new base image: 'docker push $1/phppgadmin'"
echo