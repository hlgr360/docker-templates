#!/bin/sh

docker stop taigaio || true
docker rm taigaio || true
docker build -t $1/taigaio .

echo
echo "=> To store as new base image: 'docker push $1/taigaio'"
echo
