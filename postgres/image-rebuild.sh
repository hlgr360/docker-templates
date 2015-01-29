#!/bin/bash
set -e

  #statements
docker stop postgres || true
docker rm postgres || true
docker build -t $1/postgres /app/docker/postgres

echo
echo "=> After rebuilding:"
echo "=>  (1) start the postgres container,"
echo "=>  (2) Run the rails container with an interactive shell,"
echo "=>  (3) Execute 'rake db:create', 'rake db:reset'"
echo "=>  (4) Obtain the current postgres container-id using 'docker ps'"
echo "=>  (4) Commit the running postgres container to a new image"
echo "=>      using 'docker commit -a <email> -m <comment> <container-id> $1/postgres"
echo "=>  (5) Store as new base image using 'docker push $1/postgres'"
echo