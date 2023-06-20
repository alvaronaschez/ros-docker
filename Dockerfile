ARG ROS_DISTRO=humble
FROM ros:$ROS_DISTRO
RUN apt-get update 
RUN apt-get install ros-$ROS_DISTRO-desktop-full -y
RUN apt-get install ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup ros-$ROS_DISTRO-turtlebot3* -y
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
