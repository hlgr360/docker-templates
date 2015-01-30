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


# add kiwiIRC
RUN apt-get install -y gnutls-bin git

RUN mkdir /app
WORKDIR /app

# https://github.com/prawnsalad/KiwiIRC
RUN git clone https://github.com/prawnsalad/KiwiIRC.git

WORKDIR /app/KiwiIRC
RUN npm install
add config.js /app/KiwiIRC/config.js
RUN ./kiwi build

# generate the self-signed cert for SSL
# https://help.ubuntu.com/community/GnuTLS
add sslcert.template /app/KiwiIRC/sslcert.template
RUN certtool --generate-privkey --outfile server-key.pem
RUN certtool --generate-self-signed --load-privkey server-key.pem --template sslcert.template --outfile server-cert.pem

add start-server.sh /start-server.sh


##### ... end of the build instructions ...

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose IRC ports
EXPOSE :7778

# if you execute "docker run" without arguments, run kiwiirc on foreground
CMD ["/start-server.sh"]

