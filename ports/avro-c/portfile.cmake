vcpkg_buildpath_length_warning(37)
if(VCPKG_TARGET_IS_WINDOWS)
  vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()


set(OPTIONAL_DUCKDB_PATCHES "")
if (VCPKG_TARGET_IS_EMSCRIPTEN)
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
  set(CMAKE_CXX_FLAGS " -fPIC ${VCPKG_CXX_FLAGS}" CACHE STRING "")
  set(CMAKE_C_FLAGS " -fPIC ${VCPKG_C_FLAGS}" CACHE STRING "")

  set(IS_CROSS_COMPILE 1)
  set(cross_compiling 1)
  set(VCPKG_CROSSCOMPILING 1)

  set(OPTIONAL_DUCKDB_PATCHES "${ADDITIONAL_PATCHES} static_link_only.patch")
endif()
separate_arguments(OPTIONAL_DUCKDB_PATCHES)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO duckdb/duckdb-avro-c
    REF 8af400279c445a81b8552a7670d8c1ebd92ba34a
    SHA512 56dcc4a50ded354d252709751903cd9a614fb98165727bbfa014098dffed4559bc2bff5e46882a339f92b06fa2ea40d29c95e62f12da2105b2b4657ce9f71c9d
    PATCHES
        ${OPTIONAL_DUCKDB_PATCHES}
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/lang/c"
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DBUILD_TESTS=OFF
        -DBUILD_DOCS=OFF
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
# the files are broken and there is no way to fix it because the snappy dependency has no pkgconfig file
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/pkgconfig" "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig")



if(NOT VCPKG_TARGET_IS_EMSCRIPTEN)
  vcpkg_copy_tools(TOOL_NAMES avroappend avrocat AUTO_CLEAN)

  if(NOT VCPKG_TARGET_IS_WINDOWS)
    vcpkg_copy_tools(TOOL_NAMES avropipe avromod AUTO_CLEAN)
  endif()

  if(VCPKG_LIBRARY_LINKAGE STREQUAL "static" AND NOT VCPKG_TARGET_IS_WINDOWS)
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
  endif()
endif()

file(INSTALL "${SOURCE_PATH}/lang/c/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
