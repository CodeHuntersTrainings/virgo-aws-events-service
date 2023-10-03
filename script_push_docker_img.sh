#!/bin/sh

EcrLink="584279960914.dkr.ecr.eu-central-1.amazonaws.com"
LocalImageName="events-service"

./script_docker-cleanup.sh

./mvnw clean install

docker build --tag "$LocalImageName:latest" .

aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin "$EcrLink"

docker tag "$LocalImageName:latest" "$EcrLink/eventsserviceecr:latest"

docker push "$EcrLink/eventsserviceecr:latest"