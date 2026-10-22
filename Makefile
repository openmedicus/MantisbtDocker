VERSION = 2.28.3

all: pull build tag push

pull:
	podman pull ubi9/php-83

build:
	cp -f Dockerfile.in Dockerfile
	sed -i -e 's!@VERSION@!$(VERSION)!g' Dockerfile
	podman build --no-cache --format=docker -t mantisbt .

tag:
	podman tag mantisbt openmedicus/mantisbt:$(VERSION)

push:
	podman push openmedicus/mantisbt:$(VERSION)

run:
	podman run -i -t mantisbt /bin/bash
