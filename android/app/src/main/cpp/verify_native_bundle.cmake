# SPDX-License-Identifier: MPL-2.0
cmake_policy(PUSH)
cmake_policy(SET CMP0054 NEW)
get_filename_component(FUZEVPN_ANDROID_PROJECT_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../.." ABSOLUTE)
get_filename_component(FUZEVPN_REVIEWED_BUNDLE "${CMAKE_CURRENT_LIST_DIR}/third_party" ABSOLUTE)
foreach(component IN ITEMS FUZEVPN_OPENVPN3_CORE_DIR FUZEVPN_OPENSSL_DIR FUZEVPN_OPENVPN_DEPS_DIR)
  get_filename_component(resolved "${${component}}" ABSOLUTE)
  if(component STREQUAL "FUZEVPN_OPENVPN3_CORE_DIR")
    set(expected "${FUZEVPN_REVIEWED_BUNDLE}/openvpn3-core")
  elseif(component STREQUAL "FUZEVPN_OPENSSL_DIR")
    set(expected "${FUZEVPN_REVIEWED_BUNDLE}/openssl")
  else()
    set(expected "${FUZEVPN_REVIEWED_BUNDLE}/deps")
  endif()
  if(NOT resolved STREQUAL expected)
    message(FATAL_ERROR "Unreviewed native prefix override: ${component}")
  endif()
endforeach()
find_package(Java 17 REQUIRED COMPONENTS Runtime)
execute_process(
  COMMAND "${Java_JAVA_EXECUTABLE}" --source 17
    "${FUZEVPN_ANDROID_PROJECT_DIR}/buildSrc/src/main/java/com/fuzevpn/build/NativeBundlePolicy.java"
    bundle "${FUZEVPN_REVIEWED_BUNDLE}" "${FUZEVPN_ANDROID_PROJECT_DIR}/native-provenance/bundle.sha256"
  RESULT_VARIABLE native_verify_result
  OUTPUT_VARIABLE native_verify_output
  ERROR_VARIABLE native_verify_error)
if(NOT native_verify_result EQUAL 0)
  message(FATAL_ERROR "Native provenance verification failed: ${native_verify_output}${native_verify_error}")
endif()
cmake_policy(POP)
