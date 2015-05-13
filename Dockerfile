FROM ruby:2.2-slim
MAINTAINER Michael Kuehl <hello@ratchet.cc>

RUN apt-get update && apt-get -y install build-essential

# work from here
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

# add the Gemfile and bundle all dependencies
RUN bundle install --without development test

# add the app itself
ADD . /app/

# start the app using a script
CMD ["rackup"]
