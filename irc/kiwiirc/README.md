# Docker Template: KiwiIRC

This docker template provides the 'kiwiirc' IRC Web Client on port 7778 (https). It is configured to connect to the IRC bouncer 'znc' image on port 6697.

## Website
https://kiwiirc.com

## Dependendy
### Upstream
`ngircd`
`znc`

## (Re)Building the image
`./build.sh <userid>`

## Running the image
`docker run -d --name kiwiirc --link znc:irc  -p 7778:7778 <userid>/kiwiirc`

## WebIRC client
webirc console: https://127.0.0.1:7778
username pasword: `zncuser/irc.localdomain` `zncuser`
