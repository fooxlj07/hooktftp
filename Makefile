.PHONY: build
build:
	go build ./cmd/hooktftp

.PHONY: build-docker-image
build-docker-image:
	docker build -t tftpgoteam/hooktftp:latest .

.PHONY: release-docker-image
release-docker-image: build-docker-image
	docker push tftpgoteam/hooktftp:latest

.PHONY: shell
shell: build-docker-image
	docker run --rm -ti -v $(shell pwd):/go/src/github.com/fooxlj07/hooktftp/ -w /go/src/github.com/fooxlj07/hooktftp --name hooktftp tftpgoteam/hooktftp:latest bash

.PHONY: test
test: build
	go test ./...
	$(MAKE) -C test all

.PHONY: clean
clean:
	go clean
	$(MAKE) -C test clean

.PHONY: gox
gox:
	$(MAKE) ./cmd/hooktftp
