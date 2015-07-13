FROM ubuntu:14.04.2
MAINTAINER eric.mueller@lsl.de

RUN apt-get update
RUN apt-get install -y netcat lua5.1 openssl libpcre3 dnsmasq

RUN mkdir -p /kong
ADD https://github.com/Mashape/kong/releases/download/0.3.2/kong-0.3.2.trusty_all.deb /kong/kong-0.3.2.trusty_all.deb

RUN dpkg -i /kong/kong-0.3.2.trusty_all.deb

RUN echo "deb http://www.apache.org/dist/cassandra/debian 21x main" >> /etc/apt/sources.list
RUN echo "deb-src http://www.apache.org/dist/cassandra/debian 21x main" >> /etc/apt/sources.list

RUN gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
RUN gpg --export --armor F758CE318D77295D | sudo apt-key add -

RUN gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00
RUN gpg --export --armor 2B5C1B00 | sudo apt-key add -

RUN gpg --keyserver pgp.mit.edu --recv-keys 0353B12C
RUN gpg --export --armor 0353B12C | sudo apt-key add -

RUN apt-get update

RUN apt-get install -y cassandra

CMD service cassandra start && sleep 10 && kong start && tail -f /var/log/cassandra/system.log

EXPOSE 8000
EXPOSE 8443
EXPOSE 8001
EXPOSE 8053