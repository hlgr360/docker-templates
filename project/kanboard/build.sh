#!/bin/sh

docker stop kanboard || true
docker rm kanboard || true
docker build -t $1/kanboard .

echo
echo "=> To store as new base image: 'docker push $1/kanboard'"
echo
