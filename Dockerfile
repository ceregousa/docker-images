FROM alpine:3.5

ENV DOCKER_VERSION=1.13.1 \
 DOCKER_COMPOSE_VERSION=1.10.1

# Install Docker, Docker Compose
RUN apk --update --no-cache \
    add curl device-mapper mkinitfs zsh e2fsprogs e2fsprogs-extra iptables && \
    curl https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz | tar zx && \
    mv /docker/* /bin/ && chmod +x /bin/docker* \
&& \
    apk add py-pip && \
    pip install docker-compose==${DOCKER_COMPOSE_VERSION}

RUN curl -L https://github.com/progrium/entrykit/releases/download/v0.4.0/entrykit_0.4.0_Linux_x86_64.tgz | tar zx && \
    chmod +x entrykit && \
    mv entrykit /bin/entrykit && \
    entrykit --symlink

# COPY ./docker-compose.yml /src/
# WORKDIR /src

RUN echo $'#!/bin/bash \n\
/bin/docker daemon' > /bin/docker-daemon && chmod +x /bin/docker-daemon

RUN echo $'#!/bin/bash \n\
docker info && \n\
/usr/bin/docker-compose pull && \n\
echo Cloning /var/lib/docker to /cached-graph... && \n\
ls -lah /var/lib/docker' > /bin/docker-compose-pull && chmod +x /bin/docker-compose-pull

# ENV PREHOOK_PRINT 'cat /src/docker-compose.yml'
ENV SWITCH_PULL "codep docker-daemon docker-compose-pull"
ENV SWITCH_SHELL bash
ENV CODEP_DAEMON '/bin/docker daemon'
# ENV CODEP_COMPOSE '/usr/bin/docker-compose up'

# Include useful functions to start/stop docker daemon in garden-runc containers on Concourse CI
# Its usage would be something like: source /docker.lib.sh && start_docker "" "" "-g=$(pwd)/graph"
COPY docker-lib.sh /docker-lib.sh

ENTRYPOINT ["entrykit", "-e"]
