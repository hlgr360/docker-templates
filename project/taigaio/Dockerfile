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


# Install shutit
# See https://github.com/ianmiell/shutit/blob/master/INSTALL.md
RUN apt-get install -y -qq curl git python-pip
WORKDIR /opt
RUN git clone https://github.com/ianmiell/shutit.git
WORKDIR /opt/shutit
RUN pip install -r requirements.txt

# Build taiga.io
# See https://github.com/taigaio/taiga-scripts/issues/3
# and https://zwischenzugs.wordpress.com/2014/10/07/using-shutit-to-build-your-own-taiga-server/
WORKDIR /opt/shutit/library/taigaio/bin
# RUN /opt/shutit/shutit build --shutit_module_path /opt/shutit/library --delivery bash --debug

# add start-server.sh /start-server.sh

export PATH=$PATH:/opt/shutit
export SHUTIT=/opt/shutit/shutit
chmod 0600 configs/build.cnf


##### ... end of the build instructions ...

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose Taiga.io client port
EXPOSE 8000

# if you execute "docker run" without arguments, run kiwiirc on foreground
CMD ["/start-server.sh"]
