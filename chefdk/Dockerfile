FROM ruby:2.6-slim-buster

VOLUME /data

ENV CHEFDK_VERSION=3.13.1

ADD ./resources /resources

RUN /resources/build && rm -rf /resources

WORKDIR /data