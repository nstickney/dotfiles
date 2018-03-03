#!/bin/bash
# https://techoverflow.net/2013/10/22/docker-remove-all-images-and-containers/

# Stop all containers
docker stop "$(docker ps -q)" > /dev/null 2>&1

wait

# Delete all containers
docker rm "$(docker ps -a -q)" > /dev/null 2>&1

# Delete all images
if [ "$1" == "all" ]; then
	docker rmi "$(docker images -q)" /dev/null 2>&1
elif [ "$1" == "built" ]; then
	docker images -a | grep -v -e / -e REPOSITORY | awk '{print $3}' | xargs docker rmi > /dev/null 2>&1
fi
