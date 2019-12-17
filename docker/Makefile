IMAGE = terraform-toolbox
REPO = karstenmueller
VERSION = 0.12.18

# DOCKER_USER = $(DOCKER_USER) 
# DOCKER_PASS = $(DOCKER_PASS)

.PHONY: all build test tag_latest tag_release release

all: build

tag_latest:
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest

tag_release:
	docker tag $(IMAGE):$(VERSION) $(REPO)/$(IMAGE):$(VERSION)
	docker tag $(IMAGE):$(VERSION) $(REPO)/$(IMAGE):latest

build:
	docker build -t $(IMAGE):$(VERSION) --rm .

test: tag_latest
	docker run -it --rm $(IMAGE) terraform -version
	docker run -it --rm $(IMAGE) kubectl version --short --client=true
	docker run -it --rm $(IMAGE) helm version --short
	docker run -it --rm $(IMAGE) inspec version
	docker run -it --rm $(IMAGE) gcloud version
	docker run -it --rm $(IMAGE) az --version
	docker run -it --rm $(IMAGE) aws --version

release: test tag_latest tag_release
	@if ! docker images $(IMAGE) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(IMAGE) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	echo $(DOCKER_PASS) 	docker login --username=$(DOCKER_USER) --password-stdin
	docker push $(REPO)/$(IMAGE):$(VERSION)
	docker push $(REPO)/$(IMAGE):latest
	@echo "*** Don't forget to create a tag by creating an official GitHub release."
