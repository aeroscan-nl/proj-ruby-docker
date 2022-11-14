ARG PROJ_VERSION=9.1.0

FROM osgeo/proj:${PROJ_VERSION}

ARG PROJ_VERSION
ARG RUBY_VERSION=2.7.4
ARG DEBIAN_FRONTEND=noninteractive

ENV RUBY_VERSION=${RUBY_VERSION}
ENV PROJ_VERSION=${PROJ_VERSION}

RUN apt-get update -q && \
    apt-get install -qy procps curl ca-certificates gnupg2 build-essential --no-install-recommends && apt-get clean

RUN gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

SHELL [ "/bin/bash", "-l", "-c" ]

RUN curl -sSL https://get.rvm.io | bash -s stable

RUN rvm install --default ruby-$RUBY_VERSION

