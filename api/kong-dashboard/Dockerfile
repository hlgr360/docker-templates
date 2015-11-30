FROM ubuntu:latest
MAINTAINER: martin.danielsson@haufe-lexware.com

# Install node.js
RUN apt-get update \
	&& apt-get install -yq git curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -qy nodejs python make gcc g++

# Clone Kong Dashboard
RUN git clone https://github.com/PGBI/kong-dashboard.git

# Configure npm
RUN echo '{ "allow_root": true }' > /root/.bowerrc

# For Haufe users: In order to make npm use our proxy server, uncomment this:

# RUN npm config set registry http://registry.npmjs.org/ --global
# RUN npm config set proxy http://10.12.1.236:8083 --global
# RUN npm config set https-proxy https://10.12.1.236:8083 --global

# Install Kong Dashboard
RUN cd kong-dashboard && npm install 
RUN cd kong-dashboard && npm run build

EXPOSE 8080

ADD kong-dashboard.sh /kong-dashboard.sh
RUN chmod 777 /kong-dashboard.sh
RUN cat /kong-dashboard.sh

CMD ["/kong-dashboard.sh"]

