// SPDX-License-Identifier: MPL-2.0
#pragma once

#include "openvpn_contract.h"
#include "openvpn_profile.h"

#include <memory>
#include <string_view>

namespace fuzevpn::openvpn {

struct CoreStatistics {
  long long received_bytes = 0;
  long long sent_bytes = 0;
};

class CoreSession {
 public:
  virtual ~CoreSession() = default;
  virtual bool Start(ValidatedProfile profile, std::string_view pki_alias,
                     PlatformCallbacks* callbacks) = 0;
  virtual void Stop() = 0;
  virtual bool IsConnected() const = 0;
  virtual CoreStatistics Statistics() const = 0;
};

// The unavailable implementation is used unless the exact reviewed sources
// and Android dependencies are explicitly supplied at CMake configure time.
bool IsCoreAvailable();
std::unique_ptr<CoreSession> CreateCoreSession();

}  // namespace fuzevpn::openvpn
