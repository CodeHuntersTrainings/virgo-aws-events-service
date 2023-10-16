#!/bin/sh

kubectl delete -f ./config/ingress.yml

kubectl delete -f ./config/service.yml

kubectl delete -f ./config/deployment.yml

kubectl delete -f ./config/service-account.yml

kubectl delete -f ./config/storage-class.yml

kubectl delete -f ./config/namespace.yml




