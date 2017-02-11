build:
	docker build -t ceregousa/dind .

run:
	docker run --privileged ceregousa/dind

push:
	docker push ceregousa/dind
