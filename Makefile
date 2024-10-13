NAME=docker-deb-builder
IMAGE=lcharles060/$(NAME):latest
CONTAINER=$(NAME)-run
DFILE=Dockerfile-Debian-bookworm-12
# you can pass args like "make drun arg='...'"

arg="input_repo"

main:
	cat Makefile

dbuild:
	docker build . -f $(DFILE) --tag $(IMAGE)

dpush:
	docker push $(IMAGE)

dpull:
	docker pull $(IMAGE)

#docker run -td -v $(PWD)/deb_packages:/root --name $(CONTAINER) $(IMAGE) 
drun:
	[ -d output ] || mkdir output
	./build -i $(IMAGE) -o output $(arg)

denter:
	docker exec -it $(CONTAINER) /bin/bash

dclean:
	docker rm -f $(CONTAINER)

dpurge:
	docker image rm -f $(IMAGE) 

pclean:
	rm -rf deb_packages/*

examples:
	#make drun arg="build https://github.com/lcharles123/hello-debian-package 0.1"
	#make drun arg=""
	#make drun arg=""
	#/do_build.sh build https://github.com/lcharles123/hello-debian-package 0.1 

dfresh: dclean dbuild drun denter

drerun: dclean drun

