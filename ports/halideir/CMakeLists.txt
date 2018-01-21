project (HalideIR)
option(SOURCE_PATH   "Root directory.")

file(GLOB_RECURSE SOURCES "${SOURCE_PATH}/src/*.cpp")
file(GLOB_RECURSE HEADERS "${SOURCE_PATH}/src/*.h")

find_path(DMLC_INCLUDE_DIR "dmlc/input_split_shuffle.h")

add_library(HalideIR ${SOURCES} ${HEADERS})

target_include_directories(HalideIR PUBLIC "${SOURCE_PATH}/src")
target_include_directories(HalideIR PUBLIC "${DMLC_INCLUDE_DIR}")
target_compile_definitions(HalideIR PUBLIC "Halide_SHARED")
target_compile_definitions(HalideIR PRIVATE "Halide_EXPORTS")
set_target_properties(HalideIR PROPERTIES PUBLIC_HEADER "${HEADERS}")

install(TARGETS HalideIR #EXPORT HalideIRExport
        ARCHIVE DESTINATION "lib"
        RUNTIME DESTINATION "bin"
        PUBLIC_HEADER DESTINATION "include"
        )
