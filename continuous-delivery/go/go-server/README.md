# Docker Template: GO server

This docker template provides the GO server for continuous integration.

## Website
http://www.go.cd/

## Building the image
`docker build -t go-server-image .`

## Running the image
`docker run --name go-server -d -p 8153:8153 -p 8154:8154 go-server-image`

## Accessing go-server
http://`<your-host>`:8153/