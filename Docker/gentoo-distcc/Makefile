DATE:=$(shell date '+%Y%m%d')
HOST:=docker.brainfork.org
PROJECT:=gentoo
IMAGE:=distcc

all: build push

build:
	docker build -t $(PROJECT)-$(IMAGE):$(DATE) -t $(PROJECT)-$(IMAGE):latest .

push:
	docker tag $(PROJECT)-$(IMAGE):$(DATE) $(HOST)/$(PROJECT)-$(IMAGE):$(DATE)
	docker tag $(PROJECT)-$(IMAGE):latest $(HOST)/$(PROJECT)-$(IMAGE):latest

	docker push $(HOST)/$(PROJECT)-$(IMAGE):$(DATE)
	docker push $(HOST)/$(PROJECT)-$(IMAGE):latest

run:
	docker run -it --rm $(PROJECT)
