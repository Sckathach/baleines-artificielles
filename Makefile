PORT=8888
TARGET=ml-pytorch

build: 
	sudo docker-compose build 
# run:
# sudo docker run -it --rm --gpus all -p 8888:8888 --env-file .env -v $(pwd)/workspace:/workspace
# run:
# sudo docker run -d -it -p 8888:8888 --name 404test --mount type=bind,source="$(pwd)"/workspace,target=/workspace base

up:
	sudo docker compose up -d --build $(TARGET)

run: 
	sudo docker-compose run --remove-orphans --service-ports $(TARGET)

start:
	sudo docker start $(TARGET)-container
	sudo docker exec -it $(TARGET)-container /bin/bash

rebuild:
	sudo docker-compose down
	sudo docker-compose rm -f
	sudo docker-compose up -d --build

dot:
	dot -Tpng assets/graph.dot -o assets/graph.png

jupyter_clean:
	kill -9 $(lsof -n -i4TCP:$PORT | cut -f 2 -d " ")
