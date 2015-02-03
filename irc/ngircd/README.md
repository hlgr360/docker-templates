# Docker Template: ngircd

This docker template provides the 'ngircd' IRC Daemon on port 6667. This port is used downstream by the IRC Bouncer 'znc'. Since the 'znc' exposes the secure port '6697' (SSL) to external IRC clients, the 'ngircd' container does not expose 6697 (even though it is configured).

## Dependendy
### Downstream
'znc'
'kiwiirc'

## (Re)Building the image
`./image-rebuild.sh <userid>`

## Running the image
`docker run -d --name ngircd -p 6667:6667 <userid>/ngircd`