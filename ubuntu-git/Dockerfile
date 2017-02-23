FROM ubuntu:16.04

ENV PACKAGES="build-essential software-properties-common"

RUN apt-get update -qq && apt-get install -y ${PACKAGES}
RUN apt-add-repository ppa:git-core/ppa -y && \
    apt-get update -qq && \
    apt-get install -y git
