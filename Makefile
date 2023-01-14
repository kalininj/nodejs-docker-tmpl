export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

define release
  VERSION=`node -pe "require('./package.json').version"` && \
	TAG="app:$$VERSION" && \
  echo "build $$TAG will be created" && \
  docker build --target=production -t $$TAG .
endef

.PHONY: build-dev build-dev-no-cache test start stop shell build dev-start-log

build-dev: ##@dev Build the application for dev
	docker compose build

build-dev-no-cache: ##@dev Build the application for dev without using cache
	docker compose build --no-cache

test: ##@dev Build the application to run tests
	docker build \
		--target test \
		-t app-test .

start: ##@dev Start the development environment (detached)
	docker compose up -d

stop: ##@dev Stop the development environment
	docker compose down -v

logs: ##@dev Stop the development environment
	docker compose logs -f

shell: ##@dev Go into the running container (the app name should match what's in docker-compose.yml)
	docker compose exec app /bin/bash '-l'

dev-start-log: 
	$(MAKE) stop
	$(MAKE) build-dev 
	$(MAKE) start
	$(MAKE) logs

build: ##
	$(call release)
