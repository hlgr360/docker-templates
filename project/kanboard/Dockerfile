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


# From https://github.com/fguillot/kanboard/blob/master/Dockerfile
RUN apt-get install -y apache2 php5 php5-sqlite git curl
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# install php comper for dependency management
RUN curl -sS https://getcomposer.org/installer | php -- --filename=/usr/local/bin/composer

# clone kanboard repo
RUN cd /var/www && git clone https://github.com/fguillot/kanboard.git
RUN cd /var/www/kanboard && composer install
RUN rm -rf /var/www/html && mv /var/www/kanboard /var/www/html
RUN chown -R www-data:www-data /var/www/html/data

# Set Apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# add start-server.sh /start-server.sh
ADD start-server.sh /start-server.sh


##### ... end of the build instructions ...

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose kanboard client port
EXPOSE 8000

# if you execute "docker run" without arguments, run kiwiirc on foreground
CMD ["/start-server.sh"]
