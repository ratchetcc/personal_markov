#!/bin/bash

if [ ! -d "/app" ];then
		
	echo "Creating app from repo $REPO/$BRANCH"
	
	git clone $REPO --branch $BRANCH --single-branch /app
	cd /app
	
	bundle install
	
else
	echo "Updating app from repo $REPO"
	
	cd /app
	git pull origin $BRANCH
	
	bundle install
fi

rackup -o 0.0.0.0