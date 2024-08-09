TARGET_PORT=8888

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

dot:
	dot -Tpng assets/graph.dot -o assets/graph.png

jupyter_clean:
	kill -9 $(lsof -n -i4TCP:$TARGET_PORT | cut -f 2 -d " ")
