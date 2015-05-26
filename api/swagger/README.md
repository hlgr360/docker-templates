# Docker Template: Swagger

This docker template provides the 'swagger' tooling (editor, ui).

## Website
http://www.swagger.io

## Dependendy
`none`

## Building the image
`./build.sh <userid>`

## Running the image
`docker run -i -t -p 8080:8080 <userid>/swagger /bin/bash`

## Accessing Swagger tooling
swagger-editor: 
    > cd /app/swagger-editor
    > ./node_modules/grunt-cli/bin/grunt serve
    Connect to http://127.0.0.1:8080
swagger-ui: 
    > cd /app/swagger-ui
    > ./node_modules/gulp/bin/gulp.js serve
    Connect to http://127.0.0.1:8080
