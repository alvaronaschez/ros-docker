#!/bin/bash

project_name=$1
container_name=$2
image_name=$3
user_name=joe-doe

docker run -td \
    --env="DISPLAY=$DISPLAY" \
    --net=host \
    --privileged \
    --name=$container_name \
    --volume=$(pwd):/home/$user_name/$project_name \
    --workdir=/home/$user_name/$project_name/ws \
    --env="SHELL=/bin/bash" \
    --env-file=ws/.env \
    $image_name
