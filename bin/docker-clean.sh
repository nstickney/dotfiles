#!/bin/bash

printf '%s\n' "  Stopping all containers..."
docker ps -a -q | xargs docker stop > /dev/null 2>&1
wait

printf '%s\n' "  Removing all containers..."
yes | docker container prune > /dev/null 2>&1
wait

printf '%s\n' "  Removing all created networks..."
docker network ls | awk '{print $1 " " $2}' | grep -v -e NETWORK -e bridge -e host -e none | xargs docker network rm > /dev/null 2>&1

if [ "$1" == "all" ]; then
	printf '%s\n' "  Removing all images..."
	docker images -a -q | xargs docker rmi > /dev/null 2>&1
	yes | docker system prune -a
elif [ "$1" == "built" ]; then
	printf '%s\n' "  Removing all created images..."
	docker images -a | grep -v -e / -e REPOSITORY | awk '{print $3}' | xargs docker rmi > /dev/null 2>&1
fi

printf '%s\n' "  Removing dangling volumes"
yes | docker system prune
yes | docker volume prune
