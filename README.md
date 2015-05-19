# Personal Markov

Personal Markov_, an experiment in generating random text based on classical literature and texts from the internet.

## Build 

	
	docker build -t ratchetcc/personal_markov .
	

## Run

	
	docker run -d --name markov -p 10030:9292 getmajordomus/personal_markov rackup -o 0.0.0.0
	

