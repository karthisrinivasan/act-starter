SHELL=/usr/bin/env bash
export ACT_PATH:=$(shell pwd)/src:$(ACT_PATH)

all: test

# run all tests, checking stdout and stderr against their true versions
test:
	cd test && ./run.sh 1

# run all tests, checking only stdout against its true version
test_relaxed:
	cd test && ./run.sh 0

truth:
	cd test && ./testgen.sh

cleantest:
	cd test && ./cleantest.sh

.PHONY: test test_relaxed cleantest truth 