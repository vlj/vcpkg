
if (VCPKG_TARGET_ARCHITECTURE STREQUAL x86)
    message(FATAL_ERROR "dlmc cannot be built for the x86 architecture")
endif()

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO dmlc/dmlc-core
    REF 6389c105080602d014897926a64ecfb8382001cb
    HEAD_REF master
    SHA512 60ebf277010537fcafd6a1ce2f7f5c5ec9e06d34f0a10a8e56156336b27462c4eb02ab88da37d51585622e4999c7bc44700684ca94db7ce1bdbbec3275a8a898
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib)

# install license
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/dmlc-core/LICENSE)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/dmlc-core/LICENSE ${CURRENT_PACKAGES_DIR}/share/dmlc-core/copyright)

vcpkg_copy_pdbs()
