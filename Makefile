VERSION = 2.25.7

all: pull build tag push

pull:
	sudo docker pull openmedicus/centos-lamp:7.1

build:
	cp -f Dockerfile.in Dockerfile
	sed -i -e 's!@VERSION@!$(VERSION)!g' Dockerfile
	sudo docker build --no-cache -t mantisbt .

tag:
	sudo docker tag mantisbt openmedicus/mantisbt:$(VERSION)

push:
	sudo docker push openmedicus/mantisbt:$(VERSION)

run:
	sudo docker run -i -t mantisbt /bin/bash
