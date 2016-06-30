# Docker Template: Heroku Ruby 1.9.3

This docker template provides the base docker image for the Heroku Cedar:14 stack with Ruby 1.9.3 . It is not intended as actual runtime image, but as base image to build the application image from. 

Please refer to the following article(s) describing docker-based local development for Heroku:
* https://devcenter.heroku.com/articles/local-development-with-docker
* https://hub.docker.com/r/heroku/ruby/
* http://stackoverflow.com/questions/32263307/how-to-change-the-version-of-ruby-in-a-docker-image-replace-2-2-0-with-2-0-0

Substitute the default base image descriptor `heroku/ruby` in the local application `Dockerfile` with `launchd/heroku-ruby-1.9.3`.

## Dependendy
`none`

## Building the image
`docker build -t launchd/heroku-ruby-1.9.3 .`

