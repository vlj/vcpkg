if (VCPKG_TARGET_ARCHITECTURE STREQUAL x86)
    message(FATAL_ERROR "HalideIR cannot be built for the x86 architecture")
endif()

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO dmlc/HalideIR 
    REF d91cf97d5d6cd2b47ec408bb08e978b88cbf6ab7
    HEAD_REF master
    SHA512 4c7d2c1113b54bc285039d03a5b4509b0352e18766b2775ac7af5dbdade692ff1ba916829152068473873809c28cb6efcec860e4433e72d0754d84ce551cdb65
)

vcpkg_configure_cmake(
    SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR}
    OPTIONS -DSOURCE_PATH=${SOURCE_PATH}
    PREFER_NINJA
)


vcpkg_install_cmake()
vcpkg_copy_pdbs()

# install license
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/dlpack/LICENSE)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/dlpack/LICENSE ${CURRENT_PACKAGES_DIR}/share/dlpack/copyright)

