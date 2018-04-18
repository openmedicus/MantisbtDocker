VERSION = 2.13.1

all: pull build tag push

pull:
	sudo docker pull openmedicus/centos-lamp:latest

build:
	sudo docker build --no-cache -t mantisbt .

tag:
	sudo docker tag mantisbt openmedicus/mantisbt:$(VERSION)
	sudo docker tag mantisbt openmedicus/mantisbt:latest

push:
	sudo docker push openmedicus/mantisbt:$(VERSION)
	sudo docker push openmedicus/mantisbt:latest

run:
	sudo docker run -i -t mantisbt /bin/bash
