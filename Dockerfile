FROM ruby:2.5

RUN apt-get -y update \
    && apt-get -y install libicu-dev cmake \
    && rm -rf /var/lib/apt/lists/*

RUN gem install github-linguist \
    && gem install gollum \
    && gem install org-ruby

WORKDIR /wiki

ENTRYPOINT ["gollum", "--port", "80"]

EXPOSE 80

