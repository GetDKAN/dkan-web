-include env_make

TAG ?= latest

UBUNTU_VER ?= 20.04

TAG ?= latest

REPO = getdkan/dkan-web
NAME = dkan-web

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) \
        --build-arg BASE_IMAGE_TAG=$(UBUNTU_VER) \
	./

test:
	IMAGE=$(REPO):$(TAG) echo "SKIP"

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
