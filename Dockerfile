FROM ubuntu:16.04

ENV DOCKER_COMPOSE_VERSION '1.10.1'

RUN apt-get update -q && apt-get -qy --no-install-recommends install \
    curl \
    apt-transport-https \
    ca-certificates \
    software-properties-common

RUN curl -fsSL https://apt.dockerproject.org/gpg | apt-key add - && \
    add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(cat /etc/lsb-release | grep DISTRIB_CODENAME | cut -d= -f2) main"

RUN apt-get update -q && apt-get -qy --no-install-recommends install docker-engine

# # install docker-compose
# RUN apk --update --no-cache \
#     add curl device-mapper py-pip iptables && \
#     rm -rf /var/cache/apk/* && \
#     pip install docker-compose==${DOCKER_COMPOSE_VERSION}

# install entrykit
RUN curl -L https://github.com/progrium/entrykit/releases/download/v0.4.0/entrykit_0.4.0_Linux_x86_64.tgz | tar zx && \
    chmod +x entrykit && \
    mv entrykit /bin/entrykit && \
    entrykit --symlink

# Include useful functions to start/stop docker daemon in garden-runc containers on Concourse CI
# Its usage would be something like: source /docker.lib.sh && start_docker "" "" "-g=$(pwd)/graph"
COPY docker-lib.sh /docker-lib.sh

ENTRYPOINT ["switch", "shell=/bin/sh", "--", "codep", "/usr/bin/docker daemon"]
