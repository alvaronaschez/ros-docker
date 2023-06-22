ARG ROS_DISTRO=humble
FROM ros:$ROS_DISTRO
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
#RUN if [[apt-cache search --names-only ros-$ROS_DISTRO-desktop-full]]; then apt-get install ros-$ROS_DISTRO-desktop-full -y; else apt-get install ros-$ROS_DISTRO-desktop -y; fi
RUN apt-get install ros-$ROS_DISTRO-desktop ros-dev-tools -y
RUN apt-get install ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup ros-$ROS_DISTRO-turtlebot3* -y
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# preload gazebo worlds
# https://stackoverflow.com/questions/61622351/gazebo-stuck-at-loading-your-world
RUN mkdir -p ~/.gazebo/models
WORKDIR /root/.gazebo/models
RUN wget http://file.ncnynl.com/ros/gazebo_models.txt
RUN wget -i gazebo_models.txt
RUN ls model.tar.g* | xargs -n1 tar xzvf
WORKDIR /home
