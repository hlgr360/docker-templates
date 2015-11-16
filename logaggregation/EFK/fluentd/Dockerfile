FROM fluent/fluentd:latest
MAINTAINER DORU Mihai doru.mihai@haufe-lexware.com
LABEL Description="FluentD aggregator docker image" Version="0.1"


RUN ["mkdir", "-p", "/fluentd/certs"]

RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-rdoc", "--no-ri"]
RUN ["gem", "install", "fluent-plugin-rewrite-tag-filter", "--no-rdoc", "--no-ri"]
RUN ["gem", "install", "fluent-plugin-secure-forward", "--no-rdoc", "--no-ri"]
