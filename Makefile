SHELL=/bin/bash
ros-default-distro := humble
ros-distro := $(if $(ROS_DISTRO),$(ROS_DISTRO),$(ros-default-distro))

help: # show help for each of the Makefile recipes
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

build: # build container
	docker build --tag 'ros:$(ros-distro)-desktop-full' --build-arg ROS_DISTRO=$(ros-distro) .

run: # run container for the first time
	./scripts/run_docker.sh $(ros-distro)

start: # start stopped container
	docker start ros-$(ros-distro)

stop: # stop running container
	docker stop ros-$(ros-distro)

remove: # remove stopped container
	docker rm ros-$(ros-distro)

bash: # run bash shell in running container
	docker exec -it ros-$(ros-distro) bash

shell: # run shell in running container
	docker exec -it ros-$(ros-distro) bash

print-ros-distro: # print the Ros2 distro you are using
	@echo $(ros-distro)

help-ros-distro: # show help about how to set the Ros2 distro
	@echo '*' For setting up Ros2 distro for this terminal, run:
	@echo '    export ROS_DISTRO={ros distro}'
	@echo '    example:'
	@echo '        export ROS_DISTRO=humble'
	@echo
	@echo '*' For setting up Ros2 distro in a permanent way, run:
	@echo '    echo "export ROS_DISTRO={ros distro}" >> ~/.zshrc'
	@echo '    or ~/.bashrc depending on the terminal you are using'
