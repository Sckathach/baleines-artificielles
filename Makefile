build: 
	sudo docker-compose build

run: 
	sudo docker-compose run --remove-orphans --service-ports ml-pytorch 
