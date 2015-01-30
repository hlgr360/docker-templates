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


RUN apt-get install -y gnutls-bin ngircd

add start-server.sh /start-server.sh
add ngircd.conf /etc/ngircd/ngircd.conf
add ngircd.motd /etc/ngircd/ngircd.motd

# generate the self-signed cert for SSL
WORKDIR /etc/ngircd/
add sslcert.template /etc/ngircd/sslcert.template
RUN certtool --generate-privkey --outfile server-key.pem
RUN certtool --generate-self-signed --load-privkey server-key.pem --template sslcert.template --outfile server-cert.pem
RUN certtool --generate-dh-params > dhparams.pem

RUN mkdir /app


##### ... end of the build instructions ...

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose IRC ports
EXPOSE :6667
EXPOSE :6697

# if you execute "docker run" without arguments, run ngircd on foreground
CMD ["/start-server.sh"]

