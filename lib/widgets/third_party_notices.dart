import 'package:flutter/foundation.dart';

import 'google_sdk_notices.dart';

/// Public repository of the application sources, including the MPL-2.0
/// components (application, OpenVPN 3 Core) shipped in the Android package.
/// The WireGuard AAR's GPL-2.0 wireguard-tools executables are not packaged.
const String sourceCodeRepository = 'https://github.com/FuzeVPN/android-app';

bool _thirdPartyNoticesRegistered = false;

/// Adds the notices that Google's Android SDKs declare in their AARs to the
/// license page. Android packaging drops these `third_party_licenses` files,
/// so the application must reproduce them itself. Safe to call repeatedly.
void registerThirdPartyNotices() {
  if (_thirdPartyNoticesRegistered) return;
  _thirdPartyNoticesRegistered = true;
  LicenseRegistry.addLicense(_googleSdkLicenses);
}

Stream<LicenseEntry> _googleSdkLicenses() async* {
  for (final GoogleSdkNotice notice in googleSdkNotices) {
    yield LicenseEntryWithLineBreaks(notice.packages, notice.text);
  }
}
