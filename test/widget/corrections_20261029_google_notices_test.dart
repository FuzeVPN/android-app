// Corrections du 29/10/2026, A17-supply-chain-05 (partie écran) : les notices
// tierces déclarées par les AAR Google (third_party_licenses.json/.txt de
// Billing, Play services, Google ID) ne sont pas empaquetées par Android ; elles
// doivent figurer dans le registre de licences de l'application. Contre-exemple
// de l'audit (runtime_notices_scan.py, supply_chain_consistency.py bloc 05) :
// « Protocol Buffers », « JSR 305 », « Animal Sniffer », « Checker Framework »
// absents de l'AAB et de l'écran de licences.
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/widgets/google_sdk_notices.dart';
import 'package:fuzevpn_android/widgets/third_party_notices.dart';

String _text(LicenseEntry entry) =>
    entry.paragraphs.map((paragraph) => paragraph.text).join('\n');

void main() {
  test('chaque notice reproduit à l octet près le texte de l AAR', () {
    expect(googleSdkNotices, isNotEmpty);
    for (final notice in googleSdkNotices) {
      expect(notice.packages, isNotEmpty);
      expect(
        sha256.convert(utf8.encode(notice.text)).toString(),
        notice.sha256,
        reason: notice.packages.join(', '),
      );
    }
    final hashes = googleSdkNotices.map((notice) => notice.sha256).toList();
    expect(hashes.toSet(), hasLength(hashes.length));
  });

  test(
    'le registre de licences expose les notices BSD/MIT des SDK Google',
    () async {
      registerThirdPartyNotices();
      registerThirdPartyNotices(); // idempotent
      final entries = await LicenseRegistry.licenses.toList();
      LicenseEntry single(String package) {
        final matches = entries
            .where((entry) => entry.packages.contains(package))
            .toList();
        expect(matches, hasLength(1), reason: package);
        return matches.single;
      }

      for (final (package, fragments) in [
        ('Protocol Buffers', ['Copyright 2008, Google Inc.', 'Redistribution']),
        ('Protocol Buffers for Java', ['Copyright 2008 Google Inc.']),
        ('JSR 305', ['JSR305 expert group']),
        (
          'Animal Sniffer',
          ['Kohsuke Kawaguchi', 'Permission is hereby granted'],
        ),
        ('Checker Framework Annotations', ['MIT License']),
        ('ICU4C', ['Unicode']),
        ('zlib', ['Jean-loup Gailly']),
        ('Android SDK Platforms', ['ANDROID SOFTWARE DEVELOPMENT KIT']),
      ]) {
        final text = _text(single(package));
        for (final fragment in fragments) {
          expect(text, contains(fragment), reason: package);
        }
      }
      final packages = entries.expand((entry) => entry.packages).toSet();
      expect(
        packages,
        containsAll(<String>[
          'Dagger',
          'Guava JDK7',
          'Kotlin',
          'Kotlin coroutines',
          'Tink',
          'AndroidX core library',
        ]),
      );
      for (final entry in entries) {
        expect(entry.paragraphs, isNotEmpty, reason: entry.packages.join(', '));
      }
    },
  );

  test('main.dart enregistre les notices avant runApp', () {
    final source = File('lib/main.dart').readAsStringSync();
    final register = source.indexOf('registerThirdPartyNotices();');
    expect(register, greaterThan(0));
    expect(register, lessThan(source.indexOf('runApp(')));
  });

  test('le dépôt de sources indiqué est celui de la publication', () {
    expect(sourceCodeRepository, 'https://github.com/FuzeVPN/android-app');
  });
}
