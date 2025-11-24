image_name = dGilli/htmin
image_tag = latest

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

# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## audit: run quality control checks
.PHONY: audit
audit:
	docker scan $(image_name):$(image_tag)

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

