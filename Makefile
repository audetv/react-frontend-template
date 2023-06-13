init: init-ci frontend-ready
init-ci: docker-down-clear \
	 frontend-clear \
	docker-pull docker-build docker-up \
	frontend-init
up: docker-up
down: docker-down
restart: down up
lint: frontend-lint
test: frontend-test

docker-up:
	docker compose up -d

docker-down:
	docker compose down --remove-orphans

docker-down-clear:
	docker compose down -v --remove-orphans

docker-pull:
	docker compose pull

docker-build:
	docker compose build --pull

frontend-clear:
	docker run --rm -v ${PWD}/frontend:/app -w /app alpine sh -c 'rm -rf .ready build'

frontend-init: frontend-yarn-install

frontend-yarn-install:
	docker compose run --rm frontend-node-cli yarn install

frontend-yarn-upgrade:
	docker compose run --rm frontend-node-cli yarn upgrade

frontend-ready:
	docker run --rm -v ${PWD}/frontend:/app -w /app alpine touch .ready

frontend-check: frontend-lint frontend-test

frontend-lint:
	docker compose run --rm frontend-node-cli yarn lint
	#docker compose run --rm frontend-node-cli yarn stylelint

frontend-eslint-fix:
	docker compose run --rm frontend-node-cli yarn eslint-fix

frontend-pretty:
	docker compose run --rm frontend-node-cli yarn prettier

frontend-test:
	docker compose run --rm frontend-node-cli yarn test --watchAll=false

frontend-test-watch:
	docker compose run --rm frontend-node-cli yarn test
