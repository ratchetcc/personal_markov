# Personal Markov

## Build 

	
	docker build -t ratchetcc/personal_markov .
	

## Run

	
	docker run -d --name markov -p 10030:9292 getmajordomus/personal_markov rackup -o 0.0.0.0
	

