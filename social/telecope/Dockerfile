
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

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# get the latest repos
RUN apt-get update

##### ...put your own build instructions here...


# add node.js
# https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#debian-and-ubuntu-based-linux-distributions
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

# See https://github.com/jcsaaddupuy/docker-telescope
RUN apt-get install -qq -y wget git

# add telescope user
RUN useradd -m -s /bin/bash -d /app telescope
USER telescope
ENV HOME /app
WORKDIR /app

# install meteor as non-root
RUN curl https://install.meteor.com/ | sh

# but create the necessary link as root
USER root
RUN cp "/app/.meteor/packages/meteor-tool/1.0.40/meteor-tool-os.linux.x86_64/scripts/admin/launch-meteor" /usr/bin/meteor

# continue as non-root, but splitting the following steps into indididual RUN commands will fail
# See https://groups.google.com/forum/#!topic/meteor-talk/_WFeZUZQCqY
# the root cause is two fold - node's fs won't work across partitions so this problem would probably go away with some 
# of the techniques in those links if implemented by meteor.  But this is only a problem because Docker creates a new 
# "image" for each RUN command, and so each step is isolated from the others. 
USER telescope
RUN git clone https://github.com/TelescopeJS/Telescope.git /app/telescope && \
    cd /app/telescope && \
    meteor update

# Create a /data folder for persistence
RUN mkdir /app/data

# This is weird but working, even when mounting a /data with -v
RUN ln -s /app/telescope/.meteor/local/db /app/data/telescope

# run the app on start
USER root
ADD start-server.sh /start-server.sh


##### ... end of the build instructions ...

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose Telescope client port
EXPOSE 3000

# if you execute "docker run" without arguments, run telescope on foreground
CMD ["/start-server.sh"]
