SHELL=/usr/bin/env bash
export ACT_PATH:=$(shell pwd)/src:$(ACT_PATH)

all: runtest

include $(ACT_HOME)/scripts/Makefile.std
