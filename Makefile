.DEFAULT_GOAL=help

VERSION=1.0

.PHONY:help
help:
	@echo Please make sure minikube is already started
	@echo
	@echo build - create docker images inside minikube\'s registry 

PLATFORMS = $(foreach file,$(wildcard images/*.dockerfile),$(notdir $(basename $(file))))
SSHID = id_rsa

images/id_rsa.pub: ~/.ssh/$(SSHID).pub
	cp $^ $@


.PHONY:build
build: images/$(SSHID).pub
	@cd images && for platform in $(PLATFORMS); do \
		echo; \
		echo Building: $$platform; \
		echo; \
		minikube image build -t devbox/$$platform:$(VERSION) -f $$platform.dockerfile .; \
	done


.PHONY:clean
clean:
	-rm -f images/$(SSHID).pub


