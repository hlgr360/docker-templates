# Docker Template: Kong

This docker template provides the kong api management.

## Website
http://getkong.org/

## Building the image
`docker build -t kong-image .`

## Running the image
`docker run --name kong -d -p 8000:8000 -p 8443:8443 -p 8001:8001 -p 8053:8053 kong-image`

## Running the image with docker-compose
`docker-compose up -d`