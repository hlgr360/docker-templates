# Use phusion/baseimage as base image. 
# See https://registry.hub.docker.com/u/phusion/baseimage/

# To make your builds reproducible, make sure you lock down to a specific 
# version, not to `latest`! See for a list of version numbers:
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
FROM phusion/baseimage:0.9.13
MAINTAINER holger@launchd.de

# Set correct environment variables.
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# get the latest repos
RUN apt-get update

##### ...put your own build instructions here...


# add node.js
RUN apt-get update && apt-get install -y git npm nodejs openjdk-7-jre
RUN ln -s /usr/bin/nodejs /usr/local/bin/node

# add nodejs user
RUN useradd -m -s /bin/bash -d /app nodejs
USER nodejs
ENV HOME /app

# add swagger UI
WORKDIR /app
RUN git clone https://github.com/swagger-api/swagger-ui.git
WORKDIR /app/swagger-ui
RUN npm install

# add swagger editor
WORKDIR /app
RUN git clone https://github.com/swagger-api/swagger-editor.git
WORKDIR /app/swagger-editor
RUN npm install
# http://serverfault.com/questions/548537/cant-get-bower-working-bower-esudo-cannot-be-run-with-sudo
# https://github.com/slushjs/slush-angular/issues/14
RUN node_modules/bower/bin/bower install --config.interactive=false
RUN node_modules/grunt/bin/grunt build

# run the app on start
USER root
#ADD start-server.sh /start-server.sh


##### ... end of the build instructions ...

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose Swagger UI and Editor client port
EXPOSE 8080

# if you execute "docker run" without arguments, run docker-ui in foreground
CMD ["/start-server.sh"]
