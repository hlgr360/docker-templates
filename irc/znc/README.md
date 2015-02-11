# Docker Template: znc

This docker template provides the 'znc' IRC Bouncer on port 6697 (SSL). Both external IRC clients as well as the linked web client 'kiwiirc' will connect to it. It is configured to connect to the 'ngircd' container on port 6667. The corresponding network alias is 'irc.localdomain'

## Website
http://wiki.znc.in/ZNC

## Dependencies
### Upstream
`ngircd`
### Downstream
`kiwiirc`

## (Re)Building the image
`./build.sh <userid>`

## Running the image
`docker run -d --name znc --link ngircd:irc -p 6697:6697 <userid>/znc`

## Admin Console and User Management
admin console: https://127.0.0.1:6697
username password: `zncuser` `zncuser`

## Configuring clients
Textual (MacOS): http://www.codeux.com/textual/help/Connecting-to-ZNC-Bouncer.kb
Server password: `zncuser`
User identity: `zncuser/irc.localdomain`

