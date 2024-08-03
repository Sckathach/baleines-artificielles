build: 
	sudo docker-compose build

run: 
	sudo docker-compose run --remove-orphans --service-ports ml-pytorch 

start:
	sudo docker start ml-pytorch-container
	sudo docker exec -it ml-pytorch-container /bin/bash

rebuild:
	sudo docker-compose down
	sudo docker-compose rm -f
	sudo docker-compose up -d --build
