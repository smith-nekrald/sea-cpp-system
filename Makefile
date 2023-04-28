opt: 
	make -j 12 -f makefiles/opt-makefile
dbg: 
	make -j 12 -f makefiles/debug-makefile
prof: 
	make -j 12 -f makefiles/prof-makefile
clean-common:
	rm -rf logs
	rm -rf results
	rm -rf $(shell find ./src -name '*.o')
clean-debug:
	rm -rf debug
clean-opt:
	rm -rf main
clean-prof:
	rm -rf main
	rm -rf profiler.result
	rm -rf profiler.pdf
clean:  clean-common clean-debug clean-opt
	
