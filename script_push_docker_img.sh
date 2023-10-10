#!/bin/sh

EcrLink="584279960914.dkr.ecr.eu-central-1.amazonaws.com"
LocalImageName="events-service"

./script_docker-cleanup.sh

./mvnw clean package

docker build --tag "$LocalImageName:czirjak" .

aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin "$EcrLink"

docker tag "$LocalImageName:czirjak" "$EcrLink/eventsserviceecr:czirjak"

docker push "$EcrLink/eventsserviceecr:czirjak"