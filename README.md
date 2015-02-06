Personal Markov
================

Simple Rails 4.2 template app based on TEMPLATED (http://templated.co). Nothing fancy here ...

a b

Build the Docker image
---
	
	docker build -t ratchetcc/personal_markov .
	

Run the Docker image
---
	
	docker run --name="rat_markov" --dns=8.8.8.8 -e REPO="https://github.com/ratchetcc/personal_markov.git" -p 20000:3000 ratchetcc/personal_markov
	
