#!/bin/bash

if [ ! -d "/opt/app" ];then
	apt-get update && apt-get -y install sqlite3 libsqlite3-dev
	
	echo "Creating app from repo $REPO/$BRANCH"
	
	git clone $REPO --branch $BRANCH --single-branch /opt/app
	cd /opt/app
	
	bundle install
	
	# some rails foo
#	/usr/local/bin/bundle exec rake db:create RAILS_ENV=production
#	/usr/local/bin/bundle exec rake db:migrate RAILS_ENV=production
#	/usr/local/bin/bundle exec rake db:seed RAILS_ENV=production
	
else
	echo "Updating app from repo $REPO"
	
	cd /opt/app
	git pull origin $BRANCH
	
	bundle install
	
	# some rails foo
#	/usr/local/bin/bundle exec rake db:migrate RAILS_ENV=production
fi

# more rails foo
/usr/local/bin/bundle exec rake assets:precompile RAILS_ENV=production

#/usr/local/bin/bundle exec unicorn -p 3000 -c ./config/unicorn.rb -E production
/usr/local/bin/bundle exec unicorn -p 3000 -E production
