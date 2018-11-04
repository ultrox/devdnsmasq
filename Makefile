#WARNING: This makefile is bash shell dependant!
SHELL := /bin/bash
.SHELLFLAGS := -c

restart:
	docker-compose down && docker-compose up -d
start:
	docker-compose up -d
stop:
	docker-compose down 
clean: 
	docker ps -a -q | xargs docker rm
