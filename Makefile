.PHONY:default
default:build

PLATFORMS = $(foreach file,$(wildcard */docker-compose.yaml),$(dir $(file)))
SSHID = id_rsa

id_rsa.pub: ~/.ssh/$(SSHID).pub
	cp $^ $@


.PHONY:build
build: $(SSHID).pub
	for platform in $(PLATFORMS); do (cd $$platform && docker-compose build); done


.PHONY:clean
clean:
	-rm -f $(SSHID).pub




