SHELL=/usr/bin/env bash
export ACT_PATH:=$(shell pwd)/src:$(ACT_PATH)

all: runtest

regression:
	cd test && ./testgen.sh

cleantest:
	cd test && ./cleantest.sh

include $(ACT_HOME)/scripts/Makefile.std
