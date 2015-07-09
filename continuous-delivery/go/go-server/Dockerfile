FROM ubuntu:14.04.2
MAINTAINER eric.mueller@lsl.de

RUN echo "deb http://dl.bintray.com/gocd/gocd-deb/ /" > /etc/apt/sources.list.d/gocd.list
ADD https://bintray.com/user/downloadSubjectPublicKey?username=gocd gocd-key.asc
RUN apt-key add gocd-key.asc
RUN rm gocd-key.asc

RUN apt-get update
RUN apt-get install -y go-server

CMD /etc/init.d/go-server start && tail -f /var/log/go-server/go-server.log

EXPOSE 8153
EXPOSE 8154