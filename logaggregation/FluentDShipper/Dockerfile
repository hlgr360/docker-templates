FROM fluent/fluentd:latest
MAINTAINER DORU Mihai doru.mihai@haufe-lexware.com
LABEL Description="FluentD log shipper docker image" Version="0.1"

RUN ["mkdir", "-p", "/fluentd/certs"]
RUN ["mkdir", "-p", "/fluentd/log"]

ADD ./certs/ca_cert.pem /fluentd/certs
ADD ./config/td-agent-shipper.conf /fluentd/etc

RUN ["gem", "install", "fluent-plugin-rewrite-tag-filter", "--no-rdoc", "--no-ri"]
RUN ["gem", "install", "fluent-plugin-secure-forward", "--no-rdoc", "--no-ri"]
RUN ["gem", "install", "fluent-plugin-parser", "--no-rdoc", "--no-ri"]


### Set address of fluentd aggregator instance
ENV FLUENTD_AGGREGATOR_ADDR="localhost"
ENV FLUENTD_AGGREGATOR_PORT="443"

ENV FLUENTD_CONF=td-agent-shipper.conf
### Remember to change these to match the values accepted by the aggregator
ENV FLUENTD_SHARED_KEY="default"
ENV FLUENTD_HOSTNAME="default"
ENV FLUENTD_SECURE_USERNAME="default"
ENV FLUENTD_SECURE_PASSWORD="default"

ENV FLUENTD_TAIL_TAG="default"
ENV FLUENTD_SOURCEPROJECT="default"
