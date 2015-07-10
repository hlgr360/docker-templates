FROM ubuntu:14.04.2
MAINTAINER eric.mueller@lsl.de

RUN echo "deb http://dl.bintray.com/gocd/gocd-deb/ /" > /etc/apt/sources.list.d/gocd.list
ADD https://bintray.com/user/downloadSubjectPublicKey?username=gocd gocd-key.asc
RUN apt-key add gocd-key.asc
RUN rm gocd-key.asc

RUN apt-get update
RUN apt-get install -y go-agent

ADD assets/go-agent.config /etc/default/go-agent
RUN chown go:go /etc/default/go-agent
RUN chmod 644 /etc/default/go-agent

ADD assets/autoregister.properties /var/lib/go-agent/config/autoregister.properties
RUN chown go:go /var/lib/go-agent/config/autoregister.properties
RUN chmod 644 /var/lib/go-agent/config/autoregister.properties

# INSTALL YOUR DEPLOYMENT/BUILD TOOLS HERE

CMD /etc/init.d/go-agent start