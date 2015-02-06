Personal Markov
================

Simple Rails 4.2 template app

Build the Docker image
---
	
	docker build -t ratchetcc/personal_markov .
	

Run the Docker image
---
	
	docker run --name="personal_markov" -e REPO="https://github.com/ratchetcc/personal_markov.git" -p 1010:3000 getmajordomus/personal_markov
	
