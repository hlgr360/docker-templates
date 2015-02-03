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

# See http://wiki.znc.in/ZNC and https://github.com/znc/znc

# https://noswap.com/articles/irc
# https://shellfish.io/tutorial/1/how-to-install-znc-on-debian-7/

# install dependencies
RUN apt-get install -y software-properties-common

# Install znc
RUN add-apt-repository -y ppa:teward/znc
RUN apt-get update
RUN apt-get install -y znc znc-dbg znc-dev znc-perl znc-python znc-tcl

# add znc user
RUN useradd -m -s /bin/bash -d /var/lib/znc znc

# add configuration
USER znc
WORKDIR /var/lib/znc
RUN mkdir /var/lib/znc/configs
ADD znc.conf /var/lib/znc/configs/znc.conf
RUN znc -d /var/lib/znc --makepem

USER root
# ADD does not care about USER
RUN chown znc /var/lib/znc/configs/znc.conf
add start-server.sh /start-server.sh


##### ... end of the build instructions ...

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose KiwiIRC client port
EXPOSE :6697

# if you execute "docker run" without arguments, run kiwiirc on foreground
CMD ["/start-server.sh"]

