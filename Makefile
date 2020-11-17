.PHONY: default
defualt: build

id_rsa.pub: ~/.ssh/id_rsa.pub
	cp $^ $@

build: Dockerfile docker-compose.yaml id_rsa.pub
	docker-compose build

clean:
	-rm -f id_rsa.pub
