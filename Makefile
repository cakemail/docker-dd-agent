# vim: set noexpandtab ts=2 :

NAME = docker.r53.wbsrvc.com:5000/ddagent

default:
	@echo RTFMakefile
	@false

## update the base image
update:
	docker pull $(shell awk '/^FROM/ { print $$2; exit }' Dockerfile)

## build a new version
build: update
	docker build -t $(NAME):$(shell awk '/^ENV VERSION/ { print $$3; exit }' Dockerfile) --rm .

latest:
	docker tag $(NAME):$(shell awk '/^ENV VERSION/ { print $$3; exit }' Dockerfile) $(NAME):latest

push:
	docker push $(NAME):latest
