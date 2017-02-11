build:
	docker build -t ceregousa/dind -f Dockerfile.test .

run:
	docker run --privileged ceregousa/dind

push:
	docker push ceregousa/dind
