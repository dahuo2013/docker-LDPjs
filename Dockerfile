# See: http://phusion.github.io/baseimage-docker/
# Mongodb
# https://github.com/arkadijs/mongodb-docker
# Use a specific version to be repeatable
FROM phusion/baseimage:0.9.17
WORKDIR /data

# Update and upgrade image
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && find /var/lib/apt/lists -type f -delete

RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org=2.6.5

# Install service scripts
ADD scripts/ /tmp/docker/
RUN mkdir -p /etc/service/mongodb && \
  cp /tmp/docker/mongodb.sh /etc/service/mongodb/run && \
  chmod +x /etc/service/mongodb/run
RUN mkdir -p /etc/mongodb && cp -p /tmp/docker/mongodb.yml /etc/mongodb/
VOLUME ["/data/db"]

# Install Node.js v 0.12.7
RUN apt-get -y update && \
    apt-get -y install wget && \
    apt-get -y install npm && \
    npm install -g n && \
    n 0.12.7 && \
    mkdir -p /data/LDPjs
# Install Linked Data Platform
ADD LDPjs /data/LDPjs
WORKDIR /data/LDPjs
RUN npm install

# Add a script to run the a Node app
RUN mkdir -p /etc/service/nodestart && \
  cp /tmp/docker/nodestart.sh /etc/service/nodestart/run && \
  chmod +x /etc/service/nodestart/run
# Define mountable directories for mongo and node
#VOLUME ["/vol/data/db", "/vol/node/start"]

EXPOSE 22 3000 27017 28017 8888
CMD ["/sbin/my_init"]
# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
