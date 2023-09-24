#!/bin/sh

# shellcheck disable=SC2112
function removeAllDockerContainers(){

    echo ""
    echo "**************************************"
    echo "**** Remove all Docker containers ****"
    echo "**************************************"

    docker rm -f $(docker ps -aq)

}

# shellcheck disable=SC2112
function removeAllDockerImages(){

    echo ""
    echo "**************************************"
    echo "**** Remove all Docker containers ****"
    echo "**************************************"

    docker rmi -f $(docker images -aq)

}

# shellcheck disable=SC2112
function pruneDockerVolumes(){


    echo ""
    echo "******************************"
    echo "**** Prune Docker volumes ****"
    echo "******************************"

    yes Y | docker volume prune

}

removeAllDockerContainers
removeAllDockerImages
pruneDockerVolumes
