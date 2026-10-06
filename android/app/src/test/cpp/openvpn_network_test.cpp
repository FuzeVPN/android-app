#include "../../main/cpp/openvpn_network.h"
#include <cassert>
using namespace fuzevpn::openvpn;

constexpr int NetworkCases() {
  int count = 0;
  for (const auto text : {"::", "::1", "fd0d:295d:995b:2::3", "FD0D:295D:995B:2:0:0:0:3", "1:2:3:4:5:6:7:8"}) {
    assert(ParseNumericIp(text, true).valid); ++count;
  }
  for (const auto text : {"", ":", ":::1", "1::2::3", "fd00::3%1", "::ffff:10.0.0.1", "1:2:3:4:5:6:7:8:9", "1:2:3:4:5:6:7:", "1:2:3:4:5:6:7", "1:2:3:4:5:6:7:8::", "gg::1"}) {
    assert(!ParseNumericIp(text, true).valid); ++count;
  }
  for (const auto text : {"10.0.0.3", "0.0.0.0", "255.255.255.255"}) {
    assert(ParseNumericIp(text, false).valid); ++count;
  }
  for (const auto text : {"010.0.0.3", "256.0.0.3", "10.0.3", "10.0.0.3.", "10.0.0.-3"}) {
    assert(!ParseNumericIp(text, false).valid); ++count;
  }
  assert(ParseNumericIp("fd0d:295d:995b:2::3", true) == ParseNumericIp("FD0D:295D:995B:2:0:0:0:3", true)); ++count;
  assert(IsDefaultAddress(ParseNumericIp("::", true))); ++count;
  assert(!IsDefaultAddress(ParseNumericIp("fd00::", true))); ++count;
  assert(CompleteNetwork(true, true, true, true, true, true, 1280)); ++count;
  assert(CompleteNetwork(false, true, false, true, false, true, 576)); ++count;
  for (int missing = 0; missing < 5; ++missing) {
    assert(!CompleteNetwork(true, missing != 0, missing != 1, missing != 2, missing != 3, missing != 4, 1500)); ++count;
  }
  assert(!CompleteNetwork(true, true, true, true, true, true, 1279)); ++count;
  assert(!CompleteNetwork(false, true, true, true, true, true, 1500)); ++count;
  assert(!CompleteNetwork(false, true, false, true, true, true, 1500)); ++count;
  assert(ProfileIpv6Allowed(false, true, true)); ++count;
  assert(!ProfileIpv6Allowed(false, false, false)); ++count;
  assert(ProfileIpv6Allowed(true, false, false)); ++count;
  assert(!ProfileIpv6Allowed(true, true, false)); ++count;
  assert(!ProfileIpv6Allowed(true, false, true)); ++count;
  return count;
}
static_assert(NetworkCases() == 42);
