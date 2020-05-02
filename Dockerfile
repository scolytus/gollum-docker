ARG BASE_IMAGE=ruby:2.7

FROM ${BASE_IMAGE}

RUN apt-get -y update \
    && apt-get -y install libicu-dev cmake \
    && rm -rf /var/lib/apt/lists/*

RUN gem install therubyracer gollum

RUN apt-get -y purge libicu-dev cmake

VOLUME /wiki

WORKDIR /wiki

ENTRYPOINT ["gollum"]
