cmake_minimum_required(VERSION 3.5.1
  FATAL_ERROR)

# It's actually not a true cmake way of making such things, but here its more comfortable :)
set(CMAKE_CXX_FLAGS_DEBUG "")
set(CMAKE_CXX_FLAGS_RELEASE "")

add_compile_options(
    -Wall
    -std=c++20
    -pthread
    -DHAVE_CSTDDEF
    )

include_directories(
    "/usr/local/include/coin-or",
    "/usr/include/coin",
    )

link_directories(
  )

set(SEA_LIBRARIES
    "-lOsiCbc -lCbc -lCgl -lOsiClp -lOsi -lClp -lCoinUtils -lm -lz"
    "-lbz2 -llapack -lblas -ldl -lgflags -lipopt -pthread -lunwind -lwsmp64"
    "-luuid -llog4cpp -ljsoncpp -lstdc++fs"
    )

file(GLOB_RECURSE SOURCES "src/*.cpp")

add_executable(sea ${SOURCES})

target_compile_options(sea PUBLIC -O3 -march=native -fopenmp)

target_link_libraries(sea
    ${SEA_LIBRARIES}
    )

add_executable(debug EXCLUDE_FROM_ALL ${SOURCES})

target_compile_options(debug PUBLIC
    -ggdb -pedantic -Wextra -Wformat=2 -Wlogical-op -Wcast-qual -Wcast-align -Wshadow
    -D_FORTIFY_SOURCE=2 -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC
    -fstack-protector -fsanitize=undefined -fno-sanitize-recover -fsanitize=address
    )

target_link_libraries(debug
    ${SEA_LIBRARIES}
    "-fstack-protector -fsanitize=undefined -fno-sanitize-recover -fsanitize=address"
    )
