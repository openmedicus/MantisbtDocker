VERSION = 2.24.3

all: pull build tag push

pull:
	sudo docker pull openmedicus/centos-lamp:7.1

build:
	sudo docker build --no-cache -t mantisbt .

tag:
	sudo docker tag mantisbt openmedicus/mantisbt:$(VERSION)

push:
	sudo docker push openmedicus/mantisbt:$(VERSION)

run:
	sudo docker run -i -t mantisbt /bin/bash
