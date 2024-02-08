export ACT_PATH:=$(shell ./env_setup.sh --output)

.PHONY: all regression cleantest

all: runtest

regression:
	cd test && ./testgen.sh

cleantest:
	cd test && ./cleantest.sh

include $(ACT_HOME)/scripts/Makefile.std
