REPO?=registry.lab.local
TAG?=latest

api-up:
	docker compose up -d --build

api-terminal: api-up
	docker exec -it -w /var/www tasks_api /bin/sh

api-logs:
	docker logs -f tasks_api

api-down:
	docker compose down

build-image:
	docker build -t "${REPO}/taks_api:${TAG}"

push-image:
	docker push ${REPO}/taks_api:${TAG}

remove-cache:
	find . -type d -name "__pycache__" -exec rm -r {} +

