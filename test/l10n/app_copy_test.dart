import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/widgets/notice_card.dart';

void main() {
  const capacityTitles = {
    'fr': ['Serveur complet', 'Emplacement temporairement indisponible'],
    'en': ['Server full', 'Location temporarily unavailable'],
    'es': ['Servidor completo', 'Ubicación temporalmente no disponible'],
    'de': ['Server voll', 'Standort vorübergehend nicht verfügbar'],
  };
  const capacityInstructions = {
    'fr': 'Choisissez un autre emplacement ou réessayez plus tard.',
    'en': 'Choose another location or try again later.',
    'es': 'Elige otra ubicación o inténtalo más tarde.',
    'de': 'Wähle einen anderen Standort oder versuche es später erneut.',
  };
  for (final language in ['fr', 'en', 'es', 'de']) {
    test(
      'location hierarchy labels and plural counts resolve in $language',
      () {
        final l = lookupAppLocalizations(Locale(language));
        const singulars = {
          'fr': ['pays', 'ville', 'serveur'],
          'en': ['country', 'city', 'server'],
          'es': ['país', 'ciudad', 'servidor'],
          'de': ['Land', 'Stadt', 'Server'],
        };
        const plurals = {
          'fr': ['pays', 'villes', 'serveurs'],
          'en': ['countries', 'cities', 'servers'],
          'es': ['países', 'ciudades', 'servidores'],
          'de': ['Länder', 'Städte', 'Server'],
        };
        for (final (index, key) in [
          (0, 'countryCount'),
          (1, 'cityCount'),
          (2, 'serverCount'),
        ]) {
          for (final count in [0, 1, 2, 18]) {
            final words = count == 1
                ? singulars[language]!
                : plurals[language]!;
            expect(
              AppCopy.resolve(l, 'locations.$key', arguments: {'count': count}),
              '$count ${words[index]}',
            );
          }
        }
        for (final key in [
          'automaticSelection',
          'cities',
          'servers',
          'allCountries',
          'backToCountries',
          'noCompatibleServer',
        ]) {
          final resolved = AppCopy.resolve(l, 'locations.$key');
          expect(resolved, isNotEmpty);
          expect(resolved, isNot('locations.$key'));
        }
        for (final key in [
          'viewCities',
          'viewServers',
          'backToCities',
          'chooseCountry',
          'chooseCity',
        ]) {
          for (final name in ['São Paulo', 'Côte d’Ivoire']) {
            final resolved = AppCopy.resolve(
              l,
              'locations.$key',
              arguments: {'name': name},
            );
            expect(resolved, contains(name));
            expect(resolved, isNot(contains('{name}')));
          }
        }
      },
    );
    for (final (index, code, status) in [
      (0, 'server_full', 409),
      (1, 'capacity_unavailable', 503),
    ]) {
      testWidgets(
        'API $code stays readable at 320dp and 200% text in $language',
        (tester) async {
          tester.view.physicalSize = const Size(320, 640);
          tester.view.devicePixelRatio = 1;
          tester.platformDispatcher.textScaleFactorTestValue = 2;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
          final l = lookupAppLocalizations(Locale(language));
          await tester.pumpWidget(
            _localizedApp(
              Locale(language),
              SingleChildScrollView(
                child: NoticeCard(
                  notice: AppNotice(
                    titleKey: 'notice.api.title',
                    messageKey: 'notice.api.message',
                    arguments: {'code': code},
                    diagnosticCode: 'HTTP $status · $code',
                  ),
                  onDismiss: () {},
                ),
              ),
            ),
          );

          expect(find.text(capacityTitles[language]![index]), findsOneWidget);
          expect(
            find.textContaining(capacityInstructions[language]!),
            findsOneWidget,
          );
          expect(find.textContaining('HTTP $status · $code'), findsOneWidget);
          expect(find.text(l.notice_api_message('other')), findsNothing);
          expect(tester.takeException(), isNull);
        },
      );
    }
    test('internal failures offer readable instructions in $language', () {
      final l = lookupAppLocalizations(Locale(language));
      for (final code in [
        'openvpn_native_failed',
        'native_bridge_unavailable',
        'native_operation_failed',
        'invalid_arguments',
      ]) {
        final message = AppCopy.resolve(
          l,
          'notice.native.message',
          arguments: {'code': code, 'protocol': 'VPN'},
        );
        expect(message, isNotEmpty);
        expect(message, isNot(l.notice_native_message('other', 'VPN')));
        expect(
          message,
          isNot(
            matches(
              RegExp(
                r'JNI|Kotlin|Flutter|bridge|CONNECTED|Core',
                caseSensitive: false,
              ),
            ),
          ),
        );
      }
      final stop = l.notice_controller_message(
        'flutter_disconnect_timeout',
        '',
      );
      expect(stop, isNot(contains('bridge')));
      expect(stop, contains('VPN'));
    });
    test('location result counts are rendered in $language', () {
      final l = lookupAppLocalizations(Locale(language));
      for (final count in [0, 1, 2, 18]) {
        final result = AppCopy.resolve(
          l,
          'locations.results',
          arguments: {'count': count},
        );
        expect(result, contains('$count'));
        expect(result, isNot(contains('#')));
        expect(result, isNot(contains('{count}')));
      }
    });
    test('IPv6 labels and diagnostics translated in $language', () {
      final l = lookupAppLocalizations(Locale(language));
      for (final key in [
        'network.title',
        'network.ipv4',
        'network.dualStack',
        'network.ipv4Fallback',
        'validation.passwordTooLong',
      ]) {
        expect(AppCopy.resolve(l, key), isNot(key));
        expect(AppCopy.resolve(l, key), isNotEmpty);
      }
      for (final key in [
        'accountRestoration.title',
        'accountRestoration.message',
        'action.retry',
        'protection.title',
        'protection.active',
        'protection.alwaysOnOnly',
        'protection.inactive',
        'protection.unknown',
        'protection.openSettings',
      ]) {
        expect(AppCopy.resolve(l, key), isNot(key));
        expect(AppCopy.resolve(l, key), isNotEmpty);
      }
      for (final code in [
        'tun_network_mismatch',
        'invalid_tunnel_network',
        'openvpn_network_metadata_invalid',
      ]) {
        expect(
          AppCopy.resolve(
            l,
            'notice.native.message',
            arguments: {'code': code},
          ),
          isNot(l.notice_native_message(code, 'VPN')),
        );
      }
      for (final code in [
        'system_vpn_resume_unavailable',
        'system_vpn_resume_corrupt',
        'system_vpn_resume_session_invalid',
        'system_vpn_resume_identity_changed',
        'system_vpn_resume_identity_invalid',
        'system_vpn_resume_storage_failed',
        'system_vpn_resume_network_timeout',
        'system_vpn_resume_blocked',
        'system_vpn_resume_failed',
        'system_vpn_resume_error_invalid',
        'wireguard_identity_invalid',
        'wireguard_identity_in_use',
        'wireguard_identity_store_failed',
        'wireguard_identity_unavailable',
        'vpn_host_destroyed',
        'vpn_host_unavailable',
      ]) {
        expect(l.notice_native_title(code, 'VPN'), isNotEmpty);
        expect(
          l.notice_native_title(code, 'VPN'),
          isNot(l.notice_native_title('other', 'VPN')),
        );
        expect(l.notice_native_message(code, 'VPN'), isNotEmpty);
        expect(
          l.notice_native_message(code, 'VPN'),
          isNot(l.notice_native_message('other', 'VPN')),
        );
      }
      expect(
        l.notice_api_message('ipv6_unavailable'),
        isNot(l.notice_api_message('unknown')),
      );
      expect(
        l.notice_api_message('invalid_ip_families'),
        isNot(l.notice_api_message('unknown')),
      );
    });
  }
  group('catalogues de langue générés', () {
    testWidgets('résout les messages dynamiques du catalogue anglais', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _localizedApp(
          const Locale('en'),
          Builder(
            builder: (BuildContext context) => Text(
              context.copy(
                'devices.used',
                arguments: <String, Object?>{'count': 1, 'limit': 2},
              ),
            ),
          ),
        ),
      );

      expect(find.text('1 / 2 devices'), findsOneWidget);
    });

    testWidgets('replie une langue système inconnue vers le français', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _localizedApp(
          const Locale('it'),
          Builder(
            builder: (BuildContext context) =>
                Text(context.copy('settings.language')),
          ),
        ),
      );

      expect(find.text('Langue'), findsOneWidget);
    });

    testWidgets('replie un code natif inconnu vers un message sûr', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _localizedApp(
          const Locale('de'),
          Builder(
            builder: (BuildContext context) => Text(
              context.copy(
                'notice.native.message',
                arguments: const <String, Object?>{
                  'code': 'raw_server_payload_must_not_be_shown',
                },
              ),
            ),
          ),
        ),
      );

      expect(
        find.text(
          'Ein nicht dokumentierter nativer Zweig ist fehlgeschlagen. '
          'Senden Sie den unten angezeigten Diagnosecode an den Support.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('affiche la cause native précise et son code en français', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _localizedApp(
          const Locale('fr'),
          NoticeCard(
            notice: const AppNotice(
              titleKey: 'notice.native.title',
              messageKey: 'notice.native.message',
              arguments: <String, Object?>{
                'code': 'wireguard_stop_timeout',
                'protocol': 'WireGuard',
              },
              diagnosticCode: 'WG-STOP · wireguard_stop_timeout',
            ),
            onDismiss: () {},
          ),
        ),
      );

      expect(find.text('Arrêt WireGuard non confirmé'), findsOneWidget);
      expect(
        find.text(
          'Le service WireGuard n’a pas confirmé la libération de '
          'l’interface VPN dans le délai imparti.',
        ),
        findsOneWidget,
      );
      expect(
        find.text('Code diagnostic : WG-STOP · wireguard_stop_timeout'),
        findsOneWidget,
      );
    });

    const Map<String, String> migrationByLanguage = <String, String>{
      'fr':
          'La préparation du déplacement vers Frankfurt-02 est toujours en cours.',
      'en': 'The move to Frankfurt-02 is still being prepared.',
      'es': 'Todavía se está preparando el traslado a Frankfurt-02.',
      'de': 'Der Wechsel zu Frankfurt-02 wird noch vorbereitet.',
    };
    for (final MapEntry<String, String> entry in migrationByLanguage.entries) {
      testWidgets('traduit la migration et sa destination en ${entry.key}', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          _localizedApp(
            Locale(entry.key),
            Builder(
              builder: (BuildContext context) => Text(
                context.copy(
                  'notice.controller.message',
                  arguments: const <String, Object?>{
                    'code': 'location_migration_pending',
                    'target': 'Frankfurt-02',
                  },
                ),
              ),
            ),
          ),
        );

        expect(find.textContaining(entry.value), findsOneWidget);
      });
    }

    const Map<String, String> tlsByLanguage = <String, String>{
      'fr': 'Le serveur a refusé la négociation TLS.',
      'en': 'The server rejected the TLS negotiation.',
      'es': 'El servidor rechazó la negociación TLS.',
      'de': 'Der Server hat die TLS-Aushandlung abgelehnt.',
    };
    for (final MapEntry<String, String> entry in tlsByLanguage.entries) {
      testWidgets('traduit l erreur TLS précise en ${entry.key}', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          _localizedApp(
            Locale(entry.key),
            Builder(
              builder: (BuildContext context) => Text(
                context.copy(
                  'notice.native.message',
                  arguments: const <String, Object?>{
                    'code': 'tls_handshake_failed',
                    'protocol': 'OpenVPN',
                  },
                ),
              ),
            ),
          ),
        );

        expect(find.textContaining(entry.value), findsOneWidget);
      });
    }

    testWidgets('traduit le délai API dynamique', (WidgetTester tester) async {
      await tester.pumpWidget(
        _localizedApp(
          const Locale('es'),
          Builder(
            builder: (BuildContext context) => Text(
              context.copy(
                'notice.retryAfter',
                arguments: const <String, Object?>{'seconds': 12},
              ),
            ),
          ),
        ),
      );

      expect(
        find.text('Vuelve a intentarlo dentro de 12 segundos.'),
        findsOneWidget,
      );
    });

    testWidgets('distingue l absence de preuve OpenVPN du délai réseau', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _localizedApp(
          const Locale('de'),
          Builder(
            builder: (BuildContext context) => Text(
              context.copy(
                'notice.native.message',
                arguments: const <String, Object?>{
                  'code': 'openvpn_connection_proof_missing',
                  'protocol': 'OpenVPN',
                },
              ),
            ),
          ),
        ),
      );

      expect(
        find.textContaining(
          'Die OpenVPN-Verbindung konnte nicht bestätigt werden.',
        ),
        findsOneWidget,
      );
    });
  });
}

Widget _localizedApp(Locale locale, Widget child) => MaterialApp(
  locale: locale,
  supportedLocales: const <Locale>[
    Locale('fr'),
    Locale('en'),
    Locale('es'),
    Locale('de'),
  ],
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  home: Scaffold(body: child),
);
