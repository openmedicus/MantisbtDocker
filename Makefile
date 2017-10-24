VERSION = 2.6.0

all: pull build push

pull:
	sudo docker pull openmedicus/centos-lamp:latest

build:
	sudo docker build --no-cache -t mantisbt .

push:
	sudo docker tag mantisbt openmedicus/mantisbt:$(VERSION)
	sudo docker push openmedicus/mantisbt
	sudo docker tag mantisbt openmedicus/mantisbt:latest
	sudo docker push openmedicus/mantisbt

run:
	sudo docker run -i -t mantisbt /bin/bash
