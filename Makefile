build:
	docker build -t ceregousa/dind:docker-1.13 .

run:
	docker run --privileged ceregousa/dind

push:
	docker push ceregousa/dind
