Docker Template: Kanboard

This docker template provides the 'kanboard' project management server on port 3001.

## Website
http://kanboard.net

## Dependendy
`none`

## Building the image
`./build.sh <userid>`

## Running the image
`docker run -d --name kanboard -p 80:3001 <userid>/kanboard`

## Kanboard client
console: http://127.0.0.1:3001
login: admin/admin
