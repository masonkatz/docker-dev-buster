.PHONY:default
default:build

PLATFORMS = $(foreach file,$(wildcard */docker-compose.yaml),$(dir $(file)))
SSHID = id_ed25519

ssh.pub: ~/.ssh/$(SSHID).pub
	cp $^ $@


.PHONY:build
build: ssh.pub
	for platform in $(PLATFORMS); do (cd $$platform && docker-compose build); done


.PHONY:clean
clean:
	-rm -f ssh.pub

