ARG ROS_DISTRO=humble

# https://hub.docker.com/_/ros/
# https://hub.docker.com/r/osrf/ros/
FROM osrf/ros:$ROS_DISTRO-desktop as base
# ENV DEBIAN_FRONTEND=noninteractive

# https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user
ARG USERNAME=joe-doe
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

ENV SHELL=/bin/bash
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /home/$USERNAME/.bashrc

# ros2
RUN sudo apt-get update
RUN sudo apt-get install ros-dev-tools -y


FROM base as Ros2

COPY ws /home/$USERNAME/ws
WORKDIR /home/$USERNAME/ws

# install dependencies
RUN rosdep update --include-eol-distros
RUN rosdep install --from-paths src --ignore-src -r -y

# install python dependencies
RUN sudo apt-get install python3-pip -y
RUN if [-f requirements.txt]; then pip3 install -r requirements.txt; fi

WORKDIR /home/$USERNAME
RUN sudo rm -rf ws

# preload gazebo models
# https://stackoverflow.com/questions/61622351/gazebo-stuck-at-loading-your-world
RUN sudo apt-get install wget
RUN mkdir -p /home/$USERNAME/.gazebo/models
WORKDIR /home/$USERNAME/.gazebo/models
RUN wget http://file.ncnynl.com/ros/gazebo_models.txt
RUN wget -i gazebo_models.txt
RUN ls model.tar.g* | xargs -n1 tar xzvf

RUN sudo apt-get upgrade -y

WORKDIR /home/$USERNAME
