# Personal Markov

Personal Markov_, an experiment in generating random text based on classical literature and texts from the internet.

## Build 

	
	docker build -t ratchetcc/personal_markov .
	

## Run

	
	docker run -d --name markov -p 10030:9292 -e REPO="https://github.com/ratchetcc/personal_markov.git" getmajordomus/personal_markov ./run.sh
	
