FROM getmajordomus/majord-ruby
MAINTAINER Michael Kuehl <hello@ratchet.cc>

# add the Gemfile and bundle all dependencies
WORKDIR /opt/bundle
ADD Gemfile Gemfile
RUN bundle install

# variables that controll the creation of the app
ENV REPO git_repo
ENV BRANCH master

# generic RAILS vars
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true

# app specific vars
ENV DB_NAME production.sqlite3
ENV DB_USER root
ENV DB_PWD root
ENV DB_HOST localhost
ENV DB_PORT 0
  
ENV ADMIN_NAME admin
ENV ADMIN_EMAIL admin@example.com
ENV ADMIN_PASSWORD changeme
ENV DOMAIN_NAME example.com
ENV SECRET_KEY_BASE 36572ec8b9de123fffdfaf79935ddedd1bee63ee2f9b499b56585f4a011cf97b84e3c37ea41617e19dbd93db812fec7cee44fc49cec62ea1bb5c102a6516b85d
    
# default RAILS port
EXPOSE 3000

# run the script to deploy / update the app
CMD ["/run.sh"]