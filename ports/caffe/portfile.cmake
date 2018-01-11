if (VCPKG_TARGET_ARCHITECTURE STREQUAL x86)
    message(FATAL_ERROR "Caffe cannot be built for the x86 architecture")
endif()

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO BVLC/caffe
    REF 1.0
    HEAD_REF master
    SHA512 6e80530a03eb11c77ad391cdaf4d6dfd5aad034e8e6966da15f38c6a0369f9a4510c49319116970b12874f17fbe22bf5d0ff5738ce980a0191b4d4e4187220d1
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
    ${CMAKE_CURRENT_LIST_DIR}/0001-Use-vcpkg-dependencies.patch
    ${CMAKE_CURRENT_LIST_DIR}/0002-Fix-permissive-strict.patch
    ${CMAKE_CURRENT_LIST_DIR}/0003-MSVC-fixes.patch
    ${CMAKE_CURRENT_LIST_DIR}/0004-Export-fix.patch
    ${CMAKE_CURRENT_LIST_DIR}/0005-Disable-examples.patch
    ${CMAKE_CURRENT_LIST_DIR}/0006-Do-not-rename-caffe.bin.exe-to-avoid-confusing-ninja.patch
    ${CMAKE_CURRENT_LIST_DIR}/0007-Fix-dependencies.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
    -DUSE_PREBUILT_DEPENDENCIES=OFF
    -DCPU_ONLY=ON 
    -DBUILD_python=OFF
    -DBLAS=Open
    -DUSE_LEVELDB=OFF
    -DUSE_OPENCV=OFF)

vcpkg_install_cmake()

# Remove folders from install
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/caffe.bin-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/compute_image_mean-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/convert_imageset-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/device_query-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/extract_features-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/finetune_net-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/net_speed_benchmark-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/test_net-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/train_net-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/upgrade_net_proto_binary-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/upgrade_net_proto_text-d.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/upgrade_solver_proto_text-d.exe)

file(COPY ${CURRENT_PACKAGES_DIR}/bin/caffe.bin.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/compute_image_mean.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/convert_imageset.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/device_query.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/extract_features.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/finetune_net.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/net_speed_benchmark.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/test_net.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/train_net.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/upgrade_net_proto_binary.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/upgrade_net_proto_text.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/upgrade_solver_proto_text.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/caffe.bin.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/compute_image_mean.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/convert_imageset.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/device_query.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/extract_features.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/finetune_net.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/net_speed_benchmark.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/test_net.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/train_net.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/upgrade_net_proto_binary.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/upgrade_net_proto_text.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/upgrade_solver_proto_text.exe)

file(COPY ${CURRENT_PACKAGES_DIR}/lib/caffe.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(COPY ${CURRENT_PACKAGES_DIR}/debug/lib/caffe-d.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/caffe.dll)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/caffe-d.dll)

# install license
file(COPY ${CURRENT_BUILDTREES_DIR}/src/caffe-1.0/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/caffe/LICENSE)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/caffe/LICENSE ${CURRENT_PACKAGES_DIR}/share/caffe/copyright)

vcpkg_copy_pdbs()
