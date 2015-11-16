FROM fluent/fluentd:latest
MAINTAINER DORU Mihai doru.mihai@haufe-lexware.com
LABEL Description="FluentD log shipper docker image" Version="0.1"

RUN ["mkdir", "-p", "/fluentd/certs"]

RUN ["gem", "install", "fluent-plugin-rewrite-tag-filter", "--no-rdoc", "--no-ri"]
RUN ["gem", "install", "fluent-plugin-secure-forward", "--no-rdoc", "--no-ri"]

### Set address of fluentd aggregator instance
ENV FLUENTD_AGGREGATOR_ADDR=""
ENV FLUENTD_AGGREGATOR_PORT="24284"

ONBUILD COPY ./config/td-agent-shipper.conf /fluentd/etc
ONBUILD COPY ./certs /fluentd/certs

ENV FLUENTD_CONF=td-agent-shipper.conf
