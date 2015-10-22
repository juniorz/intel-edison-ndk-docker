build:
	docker build -t juniorz/edison-ndk .

run:
	docker run -t -i -v /home/docker/shared/edison:/opt/edison juniorz/edison-ndk bash
