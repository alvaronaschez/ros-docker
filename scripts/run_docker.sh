#!/bin/bash

# If not working, first do: sudo rm -rf /tmp/.docker.xauth
# It still not working, try running the script as root.
## Build the image first
### docker build -t r2_path_planning .
## then run this script
xhost local:root

XAUTH=/tmp/.docker.xauth

ros_version=$1

docker run -it \
    --name=ros-$ros_version \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --net=host \
    --privileged \
    --env="TURTLEBOT3_MODEL=waffle" \
    --env="GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/opt/ros/$ros_version/share/turtlebot3_gazebo/models" \
    --env="BASH_ENV=~/.bashrc" \
    ros:$ros_version-desktop-full \
    bash

echo "Done."
