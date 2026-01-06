FROM ubuntu:latest

RUN apt-get update \
    && apt-get -y install curl make git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
