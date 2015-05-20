FROM ruby:2.2-slim
MAINTAINER Michael Kuehl <hello@ratchet.cc>
 
RUN apt-get update && apt-get -y install build-essential git

# variables that controll the creation of the app
ENV REPO git_repo
ENV BRANCH master

# generic vars
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV SECRET_KEY_BASE 36572ec8b9de123fffdfaf79935ddedd1bee63ee2f9b488b56575f4a011cf97b84e3c37ea41617e19dbd93db812fec7cee44fc49cec62ea1bb5c102a6516b85d
    
# default RAILS port
EXPOSE 3000

# run the script to deploy / update the app
ADD bin/run.sh /run.sh
CMD ["/run.sh"]