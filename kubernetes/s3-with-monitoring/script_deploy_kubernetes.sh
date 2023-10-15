#!/bin/sh

kubectl apply -f ./config/namespace.yml

kubectl apply -f ./config/service-account.yml

kubectl apply -f ./config/deployment.yml

kubectl apply -f ./config/service.yml

kubectl apply -f ./config/ingress.yml

kubectl apply -f ./config/service-monitor.yml

