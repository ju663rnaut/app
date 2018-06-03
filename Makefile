GO?=go
GOARCH?=amd64
GOOS?=linux
BUILD_DIR?=./build/${GOOS}-${GOARCH}

COMMIT=$(shell git rev-parse --short HEAD)
REPO=github.com/ju663rnaut/app

# Used to check if gometalinter is already installed
HAS_LINT := $(shell gometalinter.v2 -h)

# Build application
.PHONY: build
build: clean
	if ! [ -d ${BUILD_DIR} ]; then mkdir ${BUILD_DIR}; fi; \
	${GO} build -v -o ${BUILD_DIR}/app cmd/app/main.go

# Clean build folder
.PHONY: clean
clean:
	rm -r ${BUILD_DIR}/* ||:

# Run service via docker-compose
.PHONY: docker-run
docker-run:
	docker-compose up --build

# Install linter dependencies
.PHONY: lint-deps
lint-deps:
ifndef HAS_LINT
	${GO} get -u gopkg.in/alecthomas/gometalinter.v2
	gometalinter.v2 --install
endif

# Run static analysis tools
.PHONY: lint
lint: lint-deps
	gometalinter.v2 --deadline=2m --vendor ./...

# Run additional linters - they are not very critical but might be helpful
.PHONY: lint-additional
lint-additional: lint-deps
	gometalinter.v2 --enable=lll --line-length=120 \
	--enable=misspell --deadline=2m --vendor ./...

# Run service locally
.PHONY: run
run: build
	${BUILD_DIR}/app

# Runs tests and linters
.PHONY: test
test: lint test-unit

# Run unit tests
.PHONY: test-unit
test-unit:
	# race is not working in alpine image, which is used in codebuild
	#${GO} test -race ./...
	${GO} test ./...
