
include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/viennacl-dev-release-1.7.1)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/viennacl/viennacl-dev/archive/release-1.7.1.zip"
    FILENAME "viennacl-1.7.1.zip"
    SHA512 751f3afd4adbd5ec7b031bea760e6aa8447255bb57fc36de32bc764c1a9a17acdeb2ca1f917a355fd034ca06a6300f56de9923204218384316ba9145c0ded89b
)

file(REMOVE "${SOURCE_PATH}/cmake/FindOpenCL.cmake")

vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
        ${CMAKE_CURRENT_LIST_DIR}/0001-Fix-OpenCL-detection-by-CMake.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/cmake)

file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/libviennacl/viennacl.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/libviennacl/viennacl.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/libviennacl/viennacl.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/libviennacl/viennacl.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/viennacl)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/viennacl/LICENSE ${CURRENT_PACKAGES_DIR}/share/viennacl/copyright)
