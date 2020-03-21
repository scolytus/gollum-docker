FROM ruby:2.6

RUN apt-get -y update \
    && apt-get -y install libicu-dev cmake \
    && rm -rf /var/lib/apt/lists/*

RUN gem install therubyracer

#RUN mkdir -p /gollum-src \
#    && cd /gollum-src \
#    && git clone https://github.com/gollum/gollum-lib.git \
#    && git clone https://github.com/gollum/gollum \
#    && cd /gollum-src/gollum-lib \
#    && git checkout gollum-lib-5.x \
#    && git rev-parse --short HEAD > /gollum-lib.git.txt \
#    && bundle install \
#    && bundle exec rake install \
#    && cd /gollum-src/gollum \
#    && git checkout 5.x \
#    && git rev-parse --short HEAD > /gollum.git.txt \
#    && bundle install \
#    && bundle exec rake install \
#    && cd / \
#    && rm -rf /gollum-src \
#    && rm -rf /root/.bundle

RUN mkdir -p /gollum-src \
    && cd /gollum-src \
    && git clone https://github.com/gollum/gollum \
    && cd /gollum-src/gollum \
    && git checkout 5.x \
    && git rev-parse --short HEAD > /gollum.git.txt \
    && bundle install \
    && bundle exec rake install

VOLUME /wiki

WORKDIR /wiki

ENTRYPOINT ["gollum"]

