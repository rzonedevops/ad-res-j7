cmake_minimum_required(VERSION 3.14)
project(ggnumlcash-audit VERSION 1.0.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# =============================================================================
# GGNuCash.cpp Integration for Audit Analysis
# =============================================================================
#
# This CMake configuration builds the ggnumlcash.cpp library as a dependency
# and creates the audit analysis bridge for ad-res-j7.
#
# Build:
#   mkdir build && cd build
#   cmake .. -DCMAKE_BUILD_TYPE=Release
#   cmake --build . --config Release
#
# Options:
#   -DGGNUMLCASH_BUILD_EXAMPLES=OFF  Skip examples
#   -DGGNUMLCASH_CUDA=ON             Enable CUDA acceleration
#   -DGGNUMLCASH_VULKAN=ON           Enable Vulkan acceleration
# =============================================================================

option(GGNUMLCASH_BUILD_EXAMPLES "Build ggnumlcash examples" OFF)
option(GGNUMLCASH_CUDA "Enable CUDA support" OFF)
option(GGNUMLCASH_VULKAN "Enable Vulkan support" OFF)

# Add the ggnumlcash.cpp submodule
if(EXISTS "${CMAKE_SOURCE_DIR}/vendor/ggnumlcash/CMakeLists.txt")
    message(STATUS "Found ggnumlcash.cpp submodule")

    # Forward options to ggnumlcash build
    set(LLAMA_BUILD_EXAMPLES ${GGNUMLCASH_BUILD_EXAMPLES} CACHE BOOL "" FORCE)
    set(LLAMA_BUILD_TESTS OFF CACHE BOOL "" FORCE)
    set(LLAMA_BUILD_SERVER OFF CACHE BOOL "" FORCE)
    set(GGML_CUDA ${GGNUMLCASH_CUDA} CACHE BOOL "" FORCE)
    set(GGML_VULKAN ${GGNUMLCASH_VULKAN} CACHE BOOL "" FORCE)

    add_subdirectory(vendor/ggnumlcash)
else()
    message(FATAL_ERROR
        "ggnumlcash.cpp submodule not found. Run:\n"
        "  git submodule update --init vendor/ggnumlcash"
    )
endif()

# =============================================================================
# Audit Tensor Bridge Library
# =============================================================================
# Provides C API for Python/Node.js FFI integration with the financial
# tensor operations from ggnumlcash's GGML backend.
# =============================================================================

add_library(audit_tensor_bridge SHARED
    lex-inference-engine/audit_tensor_bridge.cpp
)

target_include_directories(audit_tensor_bridge PUBLIC
    ${CMAKE_SOURCE_DIR}/vendor/ggnumlcash/include
    ${CMAKE_SOURCE_DIR}/vendor/ggnumlcash/ggml/include
    ${CMAKE_SOURCE_DIR}/lex-inference-engine
)

target_link_libraries(audit_tensor_bridge PRIVATE ggml)

set_target_properties(audit_tensor_bridge PROPERTIES
    POSITION_INDEPENDENT_CODE ON
    OUTPUT_NAME "audit_tensor_bridge"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib"
)

# Install targets
install(TARGETS audit_tensor_bridge
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

message(STATUS "GGNuCash Audit Integration configured")
message(STATUS "  CUDA: ${GGNUMLCASH_CUDA}")
message(STATUS "  Vulkan: ${GGNUMLCASH_VULKAN}")
