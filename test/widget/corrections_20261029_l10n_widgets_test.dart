// Corrections du 29/10/2026, sous-lot interface et localisation :
// A05-models-02 (libellé localisé d'un appareil sans nom) et A16-ui-l10n-05
// (dates affichées dans le jour local, pas dans le jour UTC). Contre-exemple
// de l'audit : appareil créé le 2026-11-02T23:30Z affiché « Ajouté le
// 02/11/2026 » à Paris au lieu du 03/11/2026 (repros/A16-ui-l10n/
// a16_l10n_counterexamples_test.dart, « dates d appareil »).
// Réaudit final du 30/10/2026, B25 : la preuve ne dépendait que du fuseau de
// l'hôte (aucun instant de franchissement en UTC). _InstantWithLocalDay force
// un jour local différent du jour UTC, dans tout fuseau, UTC compris.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/app_formats.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/app_localization_delegates.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';

const Location _location = Location(
  id: 'paris-01',
  city: 'Paris',
  countryCode: 'FR',
  displayName: 'Paris',
);

VpnDevice _device(String name, {DateTime? createdAt}) => VpnDevice(
  deviceId: 'other-device',
  name: name,
  location: _location,
  createdAt: createdAt,
  profiles: const <VpnProfile>[],
);

/// An instant whose local calendar day differs from its UTC day on this
/// machine. Winter and summer dates cover zones that are UTC only part of the
/// year (London in November); null only on a host at UTC all year, where
/// [_InstantWithLocalDay] still proves the conversion.
DateTime? _instantCrossingLocalMidnight() {
  for (final (month, day) in [(11, 2), (7, 2), (1, 15)]) {
    for (var hour = 0; hour < 24; hour++) {
      for (final minute in [0, 15, 30, 45]) {
        final utc = DateTime.utc(2026, month, day, hour, minute);
        if (utc.toLocal().day != utc.day) return utc;
      }
    }
  }
  return null;
}

/// A UTC instant (2 November 2026, 23:30) whose [toLocal] is the next day,
/// 00:30, whatever the host time zone: formatting it shows the 3rd only if
/// the value is converted to local time first.
class _InstantWithLocalDay implements DateTime {
  final DateTime _utc = DateTime.utc(2026, 11, 2, 23, 30);
  final DateTime _local = DateTime(2026, 11, 3, 0, 30);

  @override
  DateTime toLocal() => _local;
  @override
  bool get isUtc => true;
  @override
  int get year => _utc.year;
  @override
  int get month => _utc.month;
  @override
  int get day => _utc.day;
  @override
  int get weekday => _utc.weekday;
  @override
  int get hour => _utc.hour;
  @override
  int get minute => _utc.minute;
  @override
  int get second => _utc.second;
  @override
  int get millisecond => _utc.millisecond;
  @override
  int get microsecond => _utc.microsecond;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _app(Locale locale, Widget child) => MaterialApp(
  locale: locale,
  supportedLocales: AppLanguages.supportedLocales,
  localizationsDelegates: AppLocalizationDelegates.all,
  theme: FuzeVpnTheme.light(),
  home: Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: child,
    ),
  ),
);

void main() {
  group('A05-models-02 appareil sans nom', () {
    for (final (tag, expected) in [
      ('en', 'Unnamed device'),
      ('de', 'Unbenanntes Gerät'),
      ('fr', 'Appareil sans nom'),
    ]) {
      for (final name in ['', '   ']) {
        testWidgets('$tag, nom "${name.length} espaces" : libellé localisé '
            'dans la liste et dans la confirmation', (tester) async {
          final controller = _DeviceController();
          addTearDown(controller.dispose);
          await tester.pumpWidget(
            _app(
              Locale(tag),
              DeviceRow(device: _device(name), controller: controller),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text(expected), findsOneWidget);
          if (tag != 'fr') expect(find.text('Appareil sans nom'), findsNothing);

          await tester.tap(find.byType(TextButton));
          await tester.pumpAndSettle();
          final copy = lookupAppLocalizations(Locale(tag));
          expect(find.text(copy.dialog_removeOther(expected)), findsOneWidget);
          expect(tester.takeException(), isNull);
        });
      }
    }

    testWidgets('témoin : un nom fourni reste affiché tel quel', (
      tester,
    ) async {
      final controller = _DeviceController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _app(
          const Locale('en'),
          DeviceRow(device: _device(' Pixel 9 '), controller: controller),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(' Pixel 9 '), findsOneWidget);
      expect(find.text('Unnamed device'), findsNothing);
    });
  });

  group('A16-ui-l10n-05 dates dans le jour local', () {
    testWidgets('AppFormats.date et longDate convertissent un instant UTC', (
      tester,
    ) async {
      final crossing = _instantCrossingLocalMidnight();
      final instants = [
        ?crossing,
        DateTime.utc(2026, 11, 2, 12),
        DateTime(2026, 11, 2, 23, 59),
      ];
      final results = <String>[];
      await tester.pumpWidget(
        _app(
          const Locale('fr'),
          Builder(
            builder: (context) {
              for (final instant in instants) {
                results
                  ..add(AppFormats.date(context, instant))
                  ..add(AppFormats.longDate(context, instant));
              }
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      var i = 0;
      for (final instant in instants) {
        final local = instant.toLocal();
        expect(results[i++], DateFormat.yMd('fr').format(local));
        expect(results[i++], DateFormat.yMMMMd('fr').format(local));
      }
      if (crossing != null) {
        expect(results.first, isNot(DateFormat.yMd('fr').format(crossing)));
      }
    });

    testWidgets('DeviceRow : « Ajouté le » suit le jour local', (tester) async {
      final createdAt =
          _instantCrossingLocalMidnight() ?? DateTime.utc(2026, 11, 2, 23, 30);
      final controller = _DeviceController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _app(
          const Locale('fr'),
          DeviceRow(
            device: _device('Pixel', createdAt: createdAt),
            controller: controller,
          ),
        ),
      );
      await tester.pumpAndSettle();
      final copy = lookupAppLocalizations(const Locale('fr'));
      final localDay = copy.devices_added(
        DateFormat.yMd('fr').format(createdAt.toLocal()),
      );
      expect(find.text(localDay), findsOneWidget);
      if (createdAt.toLocal().day != createdAt.day) {
        expect(
          find.text(copy.devices_added(DateFormat.yMd('fr').format(createdAt))),
          findsNothing,
        );
      }
    });

    testWidgets('garde indépendante du fuseau : date et longDate formatent '
        'value.toLocal()', (tester) async {
      final instant = _InstantWithLocalDay();
      final results = <String>[];
      await tester.pumpWidget(
        _app(
          const Locale('fr'),
          Builder(
            builder: (context) {
              results
                ..add(AppFormats.date(context, instant))
                ..add(AppFormats.longDate(context, instant));
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(results, ['03/11/2026', '3 novembre 2026']);
    });

    testWidgets('garde indépendante du fuseau : DeviceRow affiche le jour '
        'local', (tester) async {
      final controller = _DeviceController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _app(
          const Locale('fr'),
          DeviceRow(
            device: _device('Pixel', createdAt: _InstantWithLocalDay()),
            controller: controller,
          ),
        ),
      );
      await tester.pumpAndSettle();
      final copy = lookupAppLocalizations(const Locale('fr'));
      expect(find.text(copy.devices_added('03/11/2026')), findsOneWidget);
      expect(find.text(copy.devices_added('02/11/2026')), findsNothing);
    });
  });
}

class _DeviceController extends ChangeNotifier implements VpnAppController {
  @override
  String? currentDeviceId = 'current-device';

  @override
  bool isRevoking = false;

  @override
  Future<bool> revokeDevice(VpnDevice device) async => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
