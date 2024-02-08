SHELL=/usr/bin/env bash

all: runtest

regression:
	cd test && ./testgen.sh

cleantest:
	cd test && ./cleantest.sh

include $(ACT_HOME)/scripts/Makefile.std
