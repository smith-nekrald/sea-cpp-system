CC = g++
CFLAGS = -c -O0 -Wall -std=c++17 -g -ggdb
LDFLAGS = 
POSTLIBS = -lgflags -lipopt -pthread -lunwind  -lwsmp64 -luuid -llog4cpp -ljsoncpp -lstdc++fs
COINLIBS =  -lOsiCbc -lCbc -lCgl -lOsiClp -lOsi -lClp -lCoinUtils -lm -lz -lbz2 -llapack -lblas -ldl
COININC = -I /usr/local/include/coin-or -I /usr/include/coin
SOURCES = $(shell find ./code -name '*.cpp' -follow)
OBJECTS = $(SOURCES:.cpp=.o)
EXECUTABLE = main

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE) : $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@ $(COININC)  $(POSTLIBS)  $(COINLIBS)

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@ $(COININC)  $(POSTLIBS) $(COINLIBS)

clean:
	rm -rf code/*.o
	rm -rf code/gm_src/*.o
	rm -rf main
