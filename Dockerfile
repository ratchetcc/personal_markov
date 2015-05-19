FROM ruby:2.2-slim
MAINTAINER Michael Kuehl <hello@ratchet.cc>

RUN apt-get update && apt-get -y install build-essential git

# variables that controll the creation of the app
ENV REPO git_repo
ENV BRANCH master
ENV RACK_ENV production
    
# default sinatra port
EXPOSE 9292

# run the script to deploy / update the app
CMD ["/app/bin/run.sh"]