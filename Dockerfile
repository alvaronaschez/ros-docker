ARG ROS_DISTRO=humble
FROM ros:$ROS_DISTRO
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update 
#RUN if [[apt-cache search --names-only ros-$ROS_DISTRO-desktop-full]]; then apt-get install ros-$ROS_DISTRO-desktop-full -y; else apt-get install ros-$ROS_DISTRO-desktop -y; fi
RUN apt-get install ros-$ROS_DISTRO-desktop ros-dev-tools -y
RUN apt-get install ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup ros-$ROS_DISTRO-turtlebot3* -y
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
