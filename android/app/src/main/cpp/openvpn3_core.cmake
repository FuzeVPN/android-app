# SPDX-License-Identifier: MPL-2.0
#
# Strict, offline OpenVPN 3 Core integration. The exact upstream Core source
# and the OpenSSL Android archives must already be present; CMake never fetches
# a changing dependency and never falls back to an exportable private key.

# Gradle verifies this on every build, including warm builds. Verify again for
# direct CMake configuration so replacing a prefix cannot bypass that boundary.
include("${CMAKE_CURRENT_LIST_DIR}/verify_native_bundle.cmake")

set(FUZEVPN_OPENVPN3_PIN "28469efe3ae770268b2b5c6aa607ed1489e101f0")
set(FUZEVPN_OPENSSL_VERSION "3.5.9")
set(FUZEVPN_OPENSSL_INCLUDE_DIR
    "${FUZEVPN_OPENSSL_DIR}/include/${ANDROID_ABI}")
set(FUZEVPN_OPENSSL_LIB_DIR
    "${FUZEVPN_OPENSSL_DIR}/lib/${ANDROID_ABI}")

if(NOT EXISTS "${FUZEVPN_OPENVPN3_CORE_DIR}/client/ovpncli.cpp" OR
   NOT EXISTS "${FUZEVPN_OPENVPN3_CORE_DIR}/FUZEVPN-PINNED-VERSION.txt")
  message(FATAL_ERROR
    "Pinned OpenVPN 3 Core sources are absent. Run tools/import_openvpn3_openssl.ps1; no fallback source is allowed.")
endif()
if(NOT EXISTS "${FUZEVPN_OPENSSL_INCLUDE_DIR}/openssl/opensslv.h" OR
   NOT EXISTS "${FUZEVPN_OPENSSL_INCLUDE_DIR}/openssl/configuration.h" OR
   NOT EXISTS "${FUZEVPN_OPENSSL_LIB_DIR}/libssl.a" OR
   NOT EXISTS "${FUZEVPN_OPENSSL_LIB_DIR}/libcrypto.a")
  message(FATAL_ERROR
    "Pinned OpenSSL ${FUZEVPN_OPENSSL_VERSION} Android prefix is absent for ${ANDROID_ABI}.")
endif()
if(NOT EXISTS "${FUZEVPN_OPENVPN3_CORE_DIR}/openvpn/openssl/pki/xkey.hpp" OR
   NOT EXISTS "${FUZEVPN_OPENVPN3_CORE_DIR}/openvpn/openssl/xkey/xkey_provider.c" OR
   NOT EXISTS "${FUZEVPN_OPENVPN3_CORE_DIR}/openvpn/openssl/xkey/xkey_helper.c")
  message(FATAL_ERROR
    "Pinned Core lacks the upstream OpenSSL XKey External-PKI implementation.")
endif()
if(NOT EXISTS "${FUZEVPN_OPENSSL_DIR}/IMPORT-METADATA.json" OR
   NOT EXISTS "${FUZEVPN_OPENSSL_DIR}/MANIFEST.sha256")
  message(FATAL_ERROR
    "OpenSSL provenance metadata is absent; refusing an unverified archive.")
endif()

file(READ "${FUZEVPN_OPENVPN3_CORE_DIR}/FUZEVPN-PINNED-VERSION.txt"
     FUZEVPN_OPENVPN_PIN_METADATA)
string(FIND "${FUZEVPN_OPENVPN_PIN_METADATA}" "${FUZEVPN_OPENVPN3_PIN}"
       FUZEVPN_PIN_OFFSET)
if(FUZEVPN_PIN_OFFSET EQUAL -1)
  message(FATAL_ERROR
    "OpenVPN 3 Core pin metadata does not match ${FUZEVPN_OPENVPN3_PIN}.")
endif()

file(READ "${FUZEVPN_OPENSSL_INCLUDE_DIR}/openssl/opensslv.h"
     FUZEVPN_OPENSSL_VERSION_HEADER)
string(FIND "${FUZEVPN_OPENSSL_VERSION_HEADER}"
       "OPENSSL_VERSION_STR \"${FUZEVPN_OPENSSL_VERSION}\""
       FUZEVPN_OPENSSL_VERSION_OFFSET)
if(FUZEVPN_OPENSSL_VERSION_OFFSET EQUAL -1)
  message(FATAL_ERROR
    "OpenSSL headers are not the pinned ${FUZEVPN_OPENSSL_VERSION} release.")
endif()

# The selected path must be upstream XKey: EC maps to ECDSA, and OpenSSL's
# provider tells the callback whether it supplies a digest (Sign) or a message
# plus hash name (DigestSign). No application cryptographic patch is accepted.
file(READ "${FUZEVPN_OPENVPN3_CORE_DIR}/openvpn/openssl/pki/xkey.hpp"
     FUZEVPN_XKEY_SOURCE)
string(FIND "${FUZEVPN_XKEY_SOURCE}" "algstr = \"ECDSA\""
       FUZEVPN_XKEY_ECDSA_OFFSET)
string(FIND "${FUZEVPN_XKEY_SOURCE}" "xkey_load_generic_key"
       FUZEVPN_XKEY_PROVIDER_OFFSET)
if(FUZEVPN_XKEY_ECDSA_OFFSET EQUAL -1 OR
   FUZEVPN_XKEY_PROVIDER_OFFSET EQUAL -1)
  message(FATAL_ERROR
    "OpenVPN 3 Core XKey does not expose the required upstream ECDSA contract.")
endif()
file(READ "${FUZEVPN_OPENVPN3_CORE_DIR}/openvpn/mbedtls/ssl/sslctx.hpp"
     FUZEVPN_UNUSED_MBEDTLS_SOURCE)
string(FIND "${FUZEVPN_UNUSED_MBEDTLS_SOURCE}"
       "FUZEVPN_MBEDTLS_P256_EXTERNAL_PKI_CANDIDATE"
       FUZEVPN_REMOVED_CANDIDATE_OFFSET)
if(NOT FUZEVPN_REMOVED_CANDIDATE_OFFSET EQUAL -1)
  message(FATAL_ERROR
    "The removed mbedTLS P-256 candidate patch is still present in Core.")
endif()

# ovpncli.cpp is included by openvpn_core_adapter.cpp so the Android
# TunBuilder and External-PKI callbacks live in the same configured unit.
add_library(fuzevpn_openvpn_core OBJECT
  "${FUZEVPN_OPENVPN3_CORE_DIR}/openvpn/crypto/data_epoch.cpp")
target_compile_features(fuzevpn_openvpn_core PRIVATE cxx_std_20)
target_include_directories(fuzevpn_openvpn_core PRIVATE
  "${FUZEVPN_OPENVPN3_CORE_DIR}"
  "${FUZEVPN_OPENVPN_DEPS_DIR}/include"
  "${FUZEVPN_OPENSSL_INCLUDE_DIR}")
target_compile_definitions(fuzevpn_openvpn_core PRIVATE
  OPENVPN_CORE_API_VISIBILITY_HIDDEN
  OPENVPN_PLATFORM_ANDROID
  ASIO_STANDALONE
  USE_ASIO
  HAVE_LZ4
  USE_OPENSSL
  USE_TUN_BUILDER
  ENABLE_EXTERNAL_PKI
  ASIO_DISABLE_LOCAL_SOCKETS)
target_compile_options(fuzevpn_openvpn_core PRIVATE
  -Wall -Wextra -Wno-unused-parameter -fvisibility=hidden)

add_library(fuzevpn_lz4 STATIC IMPORTED GLOBAL)
set_target_properties(fuzevpn_lz4 PROPERTIES
  IMPORTED_LOCATION "${FUZEVPN_OPENVPN_DEPS_DIR}/lib/${ANDROID_ABI}/liblz4.a")
add_library(fuzevpn_fmt STATIC IMPORTED GLOBAL)
set_target_properties(fuzevpn_fmt PROPERTIES
  IMPORTED_LOCATION "${FUZEVPN_OPENVPN_DEPS_DIR}/lib/${ANDROID_ABI}/libfmt.a")
add_library(fuzevpn_openssl_ssl STATIC IMPORTED GLOBAL)
set_target_properties(fuzevpn_openssl_ssl PROPERTIES
  IMPORTED_LOCATION "${FUZEVPN_OPENSSL_LIB_DIR}/libssl.a")
add_library(fuzevpn_openssl_crypto STATIC IMPORTED GLOBAL)
set_target_properties(fuzevpn_openssl_crypto PROPERTIES
  IMPORTED_LOCATION "${FUZEVPN_OPENSSL_LIB_DIR}/libcrypto.a")
if(NOT EXISTS "${FUZEVPN_OPENVPN_DEPS_DIR}/lib/${ANDROID_ABI}/liblz4.a" OR
   NOT EXISTS "${FUZEVPN_OPENVPN_DEPS_DIR}/lib/${ANDROID_ABI}/libfmt.a")
  message(FATAL_ERROR "Missing verified lz4/fmt archive for ${ANDROID_ABI}.")
endif()

target_sources(fuzevpn_openvpn PRIVATE
  $<TARGET_OBJECTS:fuzevpn_openvpn_core>
  "${FUZEVPN_OPENVPN3_CORE_DIR}/openvpn/openssl/xkey/xkey_helper.c"
  "${FUZEVPN_OPENVPN3_CORE_DIR}/openvpn/openssl/xkey/xkey_provider.c")
target_include_directories(fuzevpn_openvpn PRIVATE
  "${FUZEVPN_OPENVPN3_CORE_DIR}"
  "${FUZEVPN_OPENVPN_DEPS_DIR}/include"
  "${FUZEVPN_OPENSSL_INCLUDE_DIR}")
target_compile_definitions(fuzevpn_openvpn PRIVATE
  OPENVPN_CORE_API_VISIBILITY_HIDDEN
  OPENVPN_PLATFORM_ANDROID
  ASIO_STANDALONE
  USE_ASIO
  HAVE_LZ4
  USE_OPENSSL
  USE_TUN_BUILDER
  ENABLE_EXTERNAL_PKI
  ASIO_DISABLE_LOCAL_SOCKETS)
target_link_options(fuzevpn_openvpn PRIVATE "-Wl,--exclude-libs,ALL")
target_link_libraries(fuzevpn_openvpn PRIVATE
  fuzevpn_openssl_ssl
  fuzevpn_openssl_crypto
  fuzevpn_lz4
  fuzevpn_fmt
  ${CMAKE_DL_LIBS})
