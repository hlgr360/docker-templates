# Docker Template: GO agent

This docker template provides the GO agent for the continuous integration GO server.

## Website
http://www.go.cd/

## Configure the agent
### GO Server
Edit `assets/go-agent.config`. Replace `<your-go-server-here>` with your GO server host.
### Autoregister the agent
Create or retrieve the autoregister key from your GO server (GO Server: `/etc/go/cruise-config.xml` -> `/cruise/server@agentAutoRegisterKey`). Edit `assets/autoregister.properties` and replace `<your-auto-register-key-here>` with your key. Also replace `<your-resource-tags-here>` with your installed  deployment/build tools (php, ant, ...).
### Add your deployment/build tools to the Dockerfile
-

## Building the image
`docker build -t go-agent-image .`

## Running the image
`docker run --name go-agent -d go-agent-image`