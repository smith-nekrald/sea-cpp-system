opt: 
	make -j 12 -f makefiles/opt-makefile
dbg: 
	make -j 12 -f makefiles/debug-makefile
prof: 
	make -j 12 -f makefiles/prof-makefile
clean:  
	rm -rf logs
	rm -rf results
	rm -rf $(shell find ./src -name '*.o')
	rm -rf debug
	rm -rf sea
	rm -rf prof 
	rm -rf profiler.result
	rm -rf profiler.pdf

