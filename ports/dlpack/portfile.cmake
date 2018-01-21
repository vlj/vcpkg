
if (VCPKG_TARGET_ARCHITECTURE STREQUAL x86)
    message(FATAL_ERROR "dlpack cannot be built for the x86 architecture")
endif()

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO dmlc/dlpack
    REF 10892ac964f1af7c81aae145cd3fab78bbccd297
    HEAD_REF master
    SHA512 5d54c1c834ebb3fae054d96933f623591e6d04399f09dd56db4fe0834ecc5d0eecfb0fa3d87e0b2ebdfb343835850e8864010c4f500df4353434cffd951e5831
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA)

file(INSTALL ${SOURCE_PATH}/include/dlpack DESTINATION ${CURRENT_PACKAGES_DIR}/include/dlpack)

# install license
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/dlpack/LICENSE)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/dlpack/LICENSE ${CURRENT_PACKAGES_DIR}/share/dlpack/copyright)
