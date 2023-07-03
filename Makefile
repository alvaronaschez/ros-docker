SHELL=/bin/bash

project-name := my-bot
ros-distro := galactic
image-repository := $(project-name)
image-tag := $(project-name)
image-name := $(image-repository):$(image-tag)
container-name := $(project-name)-container

ifeq ($(OS),Windows_NT)
	detected_OS := Windows
	create_container_script := .\docker\create_container.bat
else
	detected_OS := $(shell uname)  # same as "uname -s"
	create_container_script := ./docker/create_container.bash
endif

help: # show help for each of the Makefile recipes
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

build: # build image
	docker build \
		--tag $(image-name) \
		--build-arg ROS_DISTRO=$(ros-distro) \
		--no-cache \
		--file docker/Dockerfile .

create: # create container
	$(create_container_script) $(project-name) $(container-name) $(image-name)

start: # start stopped container
	docker start $(container-name)

stop: # stop running container
	docker stop $(container-name)

remove: # remove stopped container
	docker rm $(container-name)

remove-image: # remove the image
	docker image rm $(container-name)

bash: # run bash shell in running container
	docker exec -it $(container-name) bash

shell: # run shell in running container
	docker exec -it $(container-name) bash

clone:
	rm -rf ws/src
	git clone --recurse-submodules $(repo) ws

print-os: # print the os that has been detected
	@echo $(detected_OS)
