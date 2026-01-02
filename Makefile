image_name = dGilli/htmin
image_tag = latest

keep_alive_flag = --abort-on-container-exit 2>&1 | grep -v 'exampleapp'
ifeq ($(keep_alive),true)
	keep_alive_flag =
endif

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: confirm
confirm:
	@echo -n 'Are you sure? [y/N] ' && read ans && [ $${ans:-N} = y ]

.PHONY: no-dirty
no-dirty:
	@test -z "$(shell git status --porcelain)"

FORCE:

# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## audit: run quality control checks
.PHONY: audit
audit: test
	docker scan $(image_name):$(image_tag)

## test: run all tests
.PHONY: test
test:
	EXAMPLEAPP_IMAGE=$(image_name):$(image_tag) EXAMPLEAPP_DIR=$(shell pwd)/example COMPOSE_MENU=false \
	docker compose -f test/compose.yml up --build --quiet-build $(keep_alive_flag)

## test/%: run a single test file
test/%: FORCE
	export test_filter=$@; $(MAKE) test

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #

## clean: remove the docker image
.PHONY: clean
clean:
	docker rmi $(image_name):$(image_tag)

## build: build the docker image
.PHONY: build
build:
	docker build -t $(image_name):$(image_tag) .

## tag: tag the docker image (new_tag variable must be set)
.PHONY: tag
tag:
	docker tag $(image_name):$(image_tag) $(image_name):$(new_tag)

# ==================================================================================== #
# OPERATIONS
# ==================================================================================== #

## push: push changes to the remote Git repository
.PHONY: push
push: confirm audit no-dirty
	git push

## registry/push: push the docker image to the registry
.PHONY: production/deploy
production/: confirm audit no-dirty
	docker push $(image_name):$(image_tag)

