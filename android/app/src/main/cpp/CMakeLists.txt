# SPDX-License-Identifier: MPL-2.0
#
# OpenVPN is deliberately an opt-in native component.  A normal Android build
# produces the JNI library and an unavailable-core implementation; it never
# downloads source code or silently links an arbitrary system OpenVPN build.

cmake_minimum_required(VERSION 3.22.1)
project(fuzevpn_openvpn LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(FUZEVPN_ENABLE_OPENVPN3_CORE
       "Build the reviewed, pinned OpenVPN 3 Core integration" OFF)
set(FUZEVPN_OPENVPN3_CORE_DIR
    "${CMAKE_CURRENT_LIST_DIR}/third_party/openvpn3-core"
    CACHE PATH "Pinned OpenVPN 3 Core source directory")
set(FUZEVPN_OPENSSL_DIR
    "${CMAKE_CURRENT_LIST_DIR}/third_party/openssl"
    CACHE PATH "Pinned OpenSSL 3.5.9 Android prefix")
set(FUZEVPN_OPENVPN_DEPS_DIR
    "${CMAKE_CURRENT_LIST_DIR}/third_party/deps"
    CACHE PATH "Audited Android dependency prefix for OpenVPN 3 Core")

add_library(fuzevpn_openvpn SHARED
    openvpn_jni.cpp
    openvpn_profile.cpp)

target_compile_features(fuzevpn_openvpn PRIVATE cxx_std_20)
target_compile_options(fuzevpn_openvpn PRIVATE
    -Wall -Wextra -Wpedantic -Wformat -Wformat-security
    -fstack-protector-strong -fvisibility=hidden)
target_compile_definitions(fuzevpn_openvpn PRIVATE
    _FORTIFY_SOURCE=2
    FUZEVPN_OPENVPN_JNI_API=1)

find_library(android-lib android)
find_library(log-lib log)
target_link_libraries(fuzevpn_openvpn PRIVATE ${android-lib} ${log-lib})

if(FUZEVPN_ENABLE_OPENVPN3_CORE)
  include(openvpn3_core.cmake)
  target_sources(fuzevpn_openvpn PRIVATE openvpn_core_adapter.cpp)
  target_compile_definitions(fuzevpn_openvpn PRIVATE FUZEVPN_WITH_OPENVPN3_CORE=1)
else()
  target_sources(fuzevpn_openvpn PRIVATE openvpn_core_unavailable.cpp)
  target_compile_definitions(fuzevpn_openvpn PRIVATE FUZEVPN_WITH_OPENVPN3_CORE=0)
endif()
