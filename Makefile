override DOCKER         = $(shell which docker)
override PROJECT_NAME   = nexus-cli
override GOBIN          = ${shell pwd}/bin

GO_COMPILER_IMAGE ?= golang:1.17

.PHONY: help
help:
	@echo "usage: make <option>"
	@echo "help: Show help"
	@echo "default: Default compiler type"
	@echo "install: Compiler a binary for this project"
	@echo "docker_install: Compiler a binary with docker for this project"
	@echo "clean: Clean binary"

.PHONY: default
default: install

.PHONY: install
install:
	@go build -o $(GOBIN)/$(PROJECT_NAME)

.PHONY: docker_install
docker_install:
	$(DOCKER) run -v $(shell pwd):/universe --rm $(GO_COMPILER_IMAGE) sh -c "export GOPROXY=https://goproxy.cn && cd /universe && make install"

.PHONY: clean
clean:
	@if [ -d $(GOBIN) ];then rm -rf $(GOBIN);fi


