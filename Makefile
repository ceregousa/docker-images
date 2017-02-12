build:
	docker build -t ceregousa/dind:ruby-2.2 .

run:
	docker run --privileged ceregousa/dind

push:
	docker push ceregousa/dind
