SHELL=/usr/bin/env bash
export ACT_PATH:=$(shell pwd)/src:$(ACT_PATH)
export ACT_PATH:=$(shell pwd)/synth:$(ACT_PATH)
export ACT_TEST_VERBOSE=0

TECH=tsmc65
REF=1

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

synth:
	synth2 -F ring -E abc -e expr.act -o ring_top.act -p top src/top.act

actsim: 
	actsim src/top.act top < actsim.scr > actsim.out

actsim1: 
	actsim -ref=$(REF) ring_top.act ring_top < actsim.scr > actsim.out

actsim_xyce: 
	if [ ! -d xyce_out ]; then mkdir xyce_out; fi
	actsim -ref=$(REF) -T$(TECH) -cnf=top.conf ring_top.act ring_top < actsim.scr > actsim.out

layout: 
	if [ ! -d layout ]; then mkdir layout; fi
	interact -ref=$(REF) -T$(TECH) << source scripts/cell_gen.scr ; 
	interact -ref=$(REF) -T$(TECH) << source scripts/layout.scr

clean:
	rm _xyce.* xyce_out/xyce_out.* .actsim_history actsim.out 

cleansynth:
	rm expr.act ring_top.act

realclean:
	rm _xyce.* xyce_out/xyce_out.* layout/* dali* cells.act 

.PHONY: test test_relaxed cleantest truth synth actsim actsim1 layout actsim_xyce clean realclean cleansynth