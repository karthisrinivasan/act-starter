export ACT_PATH:=$(shell ./env_setup.sh --output)

.PHONY: all regression cleantest

all: runtest

regression:
	cd test && ./generate_regression_truth.sh

cleantest:
	cd test && ./cleantest.sh

include $(ACT_HOME)/scripts/Makefile.std
