#!/bin/sh

EcrLink=" ??? "
LocalImageName="events-service"

./script_docker-cleanup.sh

./mvnw clean install

docker build --tag "$LocalImageName:latest" .

aws ecr get-login-password --region ??? | docker login --username AWS --password-stdin "$EcrLink"

docker tag "$LocalImageName:latest" " ??? "

docker push "$EcrLink/eventsserviceecr:latest"