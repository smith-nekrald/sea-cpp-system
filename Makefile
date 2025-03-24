SHELL := /bin/bash

opt: 
	source compilers.sh
	make -j 8 -f makefiles/opt-makefile
dbg: 
	source compilers.sh
	make -j 8 -f makefiles/debug-makefile
prof: 
	source compilers.sh
	make -j 8 -f makefiles/prof-makefile
clean:  
	rm -rf logs
	rm -rf results
	rm -rf $(shell find ./src -name '*.o')
	rm -rf debug
	rm -rf sea
	rm -rf prof 
	rm -rf profiler.result
	rm -rf profiler.pdf

