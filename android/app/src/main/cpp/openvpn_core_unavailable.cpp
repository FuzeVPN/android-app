// SPDX-License-Identifier: MPL-2.0

#include "openvpn_core.h"

namespace fuzevpn::openvpn {
namespace {

class UnavailableCoreSession final : public CoreSession {
 public:
  bool Start(ValidatedProfile profile, std::string_view pki_alias,
             PlatformCallbacks* callbacks) override {
    SecureErase(&profile.content);
    (void)pki_alias;
    if (callbacks != nullptr) callbacks->OnCoreState("error", "core_unavailable");
    return false;
  }
  void Stop() override {}
  bool IsConnected() const override { return false; }
  CoreStatistics Statistics() const override { return {}; }
};

}  // namespace

bool IsCoreAvailable() { return false; }

std::unique_ptr<CoreSession> CreateCoreSession() {
  return std::make_unique<UnavailableCoreSession>();
}

}  // namespace fuzevpn::openvpn
