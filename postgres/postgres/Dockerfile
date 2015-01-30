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

# See http://docs.docker.com/examples/postgresql_service/

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release of PostgreSQL, ``9.3``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Install PostgreSQL 9.3 and phppgadmin tool
RUN apt-get install -y postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

# Run the rest of the commands as the ``postgres`` user 
# created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER postgres

# Add VOLUMEs to allow backup of config, logs and databases
# Note: Tagging a directory as volume will prevent preserving its state during docker commit
#VOLUME  ["/var/lib/postgresql"]

USER root

# Add postgresql config files
ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

# Database server
ADD start-server.sh /start-server.sh
RUN chmod +x /start-server.sh

##### ... end of the build instructions ...


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the PostgreSQL port
EXPOSE 5432

# Set the default command to run when starting the container
CMD ["/start-server.sh"]
