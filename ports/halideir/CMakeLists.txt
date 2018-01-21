# CMAKE project for duktape
option(SOURCE_PATH   "Root directory.")

project (HalideIR)

file(GLOB_RECURSE SOURCES "${SOURCE_PATH}/src/*.cpp")
file(GLOB_RECURSE HEADERS "${SOURCE_PATH}/src/*.h")

find_package(dlmc REQUIRED)

add_library(HalideIR ${SOURCES} ${HEADERS})

target_include_directories(HalideIR PUBLIC ${SOURCE_PATH}/src)
target_link_libraries(HalideIR PUBLIC dlmc)

install(TARGETS HalideIR
        ARCHIVE DESTINATION "lib"
        RUNTIME DESTINATION "bin"
        PUBLIC_HEADER DESTINATION "include")
