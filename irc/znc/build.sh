#!/bin/sh

docker stop znc || true
docker rm znc || true
docker build -t $1/znc .

echo
echo "=> To store as new base image: 'docker push $1/znc'"
echo
