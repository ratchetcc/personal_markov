#!/bin/bash

if [ ! -d "/app" ];then
	echo "Creating app from repo $REPO/$BRANCH"
	
	git clone $REPO --branch $BRANCH --single-branch /app
	cd /app
	
	bundle install
	
	# some rails foo
#	/usr/local/bin/bundle exec rake db:create RAILS_ENV=production
#	/usr/local/bin/bundle exec rake db:migrate RAILS_ENV=production
#	/usr/local/bin/bundle exec rake db:seed RAILS_ENV=production
	
else
	echo "Updating app from repo $REPO"
	
	cd /app
	git pull origin $BRANCH
	
	bundle install
	
	# some rails foo
#	/usr/local/bin/bundle exec rake db:migrate RAILS_ENV=production
fi

# more rails foo
/usr/local/bin/bundle exec rake assets:precompile RAILS_ENV=production

# start the app server
/usr/local/bin/bundle exec rails s -b 0.0.0.0 -e $RAILS_ENV