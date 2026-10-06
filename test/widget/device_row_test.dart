import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';
import 'package:intl/intl.dart';

const Location _deviceLocation = Location(
  id: 'frankfurt-01',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 01',
);

VpnDevice _device(String id, String name) => VpnDevice(
  deviceId: id,
  name: name,
  location: _deviceLocation,
  createdAt: DateTime.utc(2026, 9, 29),
  profiles: const <VpnProfile>[
    VpnProfile(protocol: VpnProtocol.wireGuard, status: 'active'),
    VpnProfile(protocol: VpnProtocol.openVpn, status: 'active'),
  ],
);

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await (FontLoader(
      'Archivo',
    )..addFont(rootBundle.load('assets/fonts/Archivo-Variable.ttf'))).load();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });

  for (final String language in <String>['fr', 'en', 'es', 'de']) {
    for (final double width in <double>[320, 412]) {
      for (final bool dark in <bool>[false, true]) {
        testWidgets(
          'current device stays readable at 200% ($language, $width, dark=$dark)',
          (WidgetTester tester) async {
            tester.view.physicalSize = Size(width, 915);
            tester.view.devicePixelRatio = 1;
            tester.platformDispatcher.textScaleFactorTestValue = 2;
            addTearDown(tester.view.resetPhysicalSize);
            addTearDown(tester.view.resetDevicePixelRatio);
            addTearDown(
              tester.platformDispatcher.clearTextScaleFactorTestValue,
            );
            final VpnAppController controller = VpnAppController(
              api: _UnusedApi(),
              sessionStore: _UnusedStore(),
              preferences: _UnusedPreferences(),
              tunnel: _IdleTunnel(),
            )..currentDeviceId = 'current-device';
            addTearDown(controller.dispose);
            final VpnDevice device = _device(
              'current-device',
              'Redmi Note 13 Pro',
            );
            await tester.pumpWidget(
              MaterialApp(
                locale: Locale(language),
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                theme: dark ? FuzeVpnTheme.dark() : FuzeVpnTheme.light(),
                home: Scaffold(
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: DeviceRow(device: device, controller: controller),
                  ),
                ),
              ),
            );
            await tester.pumpAndSettle();
            expect(tester.takeException(), isNull);
            final AppLocalizations copy = AppLocalizations.of(
              tester.element(find.byType(DeviceRow)),
            );
            expect(find.text(copy.devices_thisDevice), findsOneWidget);
            expect(
              find.text(
                copy.devices_added(
                  DateFormat.yMd(language).format(device.createdAt!),
                ),
              ),
              findsOneWidget,
            );
            expect(find.textContaining('Frankfurt'), findsNothing);
            expect(find.textContaining('WireGuard'), findsNothing);
            expect(find.textContaining('OpenVPN'), findsNothing);
            final Size nameSize = tester.getSize(find.text(device.name));
            // A non-overflowing card can still crush its name into one-letter
            // lines. Preserve readable text and an accessible removal action.
            expect(nameSize.width, greaterThan(160));
            expect(nameSize.height, lessThan(140));
            expect(
              tester.getRect(find.byType(TextButton)).bottom,
              lessThan(915),
            );
          },
        );
      }
    }
  }

  testWidgets('removing a named device requires explicit confirmation', (
    WidgetTester tester,
  ) async {
    final _DeviceController controller = _DeviceController()
      ..currentDeviceId = 'current-device';
    addTearDown(controller.dispose);
    final VpnDevice device = _device('other-device', 'Ordinateur du salon');
    await tester.pumpWidget(_deviceApp(controller, device));
    await tester.pumpAndSettle();
    expect(find.text(device.name), findsOneWidget);
    expect(find.text('Cet appareil'), findsNothing);

    await tester.tap(find.widgetWithText(TextButton, 'Retirer'));
    await tester.pumpAndSettle();
    final AppLocalizations copy = AppLocalizations.of(
      tester.element(find.byType(AlertDialog)),
    );
    expect(find.text(copy.dialog_removeOther(device.name)), findsOneWidget);
    expect(find.textContaining('Frankfurt'), findsNothing);
    expect(find.textContaining('WireGuard'), findsNothing);
    expect(find.textContaining('OpenVPN'), findsNothing);
    expect(controller.revocationRequests, isEmpty);

    await tester.tap(find.widgetWithText(TextButton, 'Annuler'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(controller.revocationRequests, isEmpty);

    await tester.tap(find.widgetWithText(TextButton, 'Retirer'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Retirer'));
    await tester.pumpAndSettle();
    expect(controller.revocationRequests, <VpnDevice>[device]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('current-device removal retains its disconnection warning', (
    WidgetTester tester,
  ) async {
    final _DeviceController controller = _DeviceController()
      ..currentDeviceId = 'current-device';
    addTearDown(controller.dispose);
    final VpnDevice device = _device('current-device', 'FuzeVPN — Android');
    await tester.pumpWidget(_deviceApp(controller, device));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Retirer'));
    await tester.pumpAndSettle();
    final AppLocalizations copy = AppLocalizations.of(
      tester.element(find.byType(AlertDialog)),
    );
    expect(find.text(copy.dialog_removeCurrent), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Annuler'));
    await tester.pumpAndSettle();
    expect(controller.revocationRequests, isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'simplified device list stays readable at 320dp and 200%',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320, 915);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final VpnAppController controller =
          VpnAppController(
              api: _UnusedApi(),
              sessionStore: _UnusedStore(),
              preferences: _UnusedPreferences(),
              tunnel: _IdleTunnel(),
            )
            ..currentDeviceId = 'current-device'
            ..deviceList = DeviceList(
              limit: 3,
              devices: <VpnDevice>[
                _device('current-device', 'FuzeVPN — Android'),
                _device('other-device', 'Ordinateur du salon'),
              ],
            );
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: FuzeVpnTheme.light(),
          home: Scaffold(body: AccountPage(controller: controller)),
        ),
      );
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('account-devices')),
        240,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gérer mes appareils'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('account-devices')));
      await tester.pumpAndSettle();
      final List<Image> images = tester
          .widgetList<Image>(find.byType(Image))
          .toList(growable: false);
      final BuildContext context = tester.element(find.byType(Scaffold));
      await tester.runAsync(() async {
        await Future.wait(
          images.map((image) => precacheImage(image.image, context)),
        );
      });
      await tester.pumpAndSettle();
      expect(find.byType(DeviceRow), findsNWidgets(2));
      expect(find.text('Cet appareil'), findsOneWidget);
      expect(find.textContaining('Frankfurt'), findsNothing);
      expect(find.textContaining('WireGuard'), findsNothing);
      expect(find.textContaining('OpenVPN'), findsNothing);
      for (final VpnDevice device in controller.deviceList.devices) {
        expect(tester.getSize(find.text(device.name)).width, greaterThan(200));
      }
      expect(tester.takeException(), isNull);
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile(_goldenPath('account_devices_simplified_200.png')),
      );
    },
    tags: <String>['golden'],
  );
}

Widget _deviceApp(VpnAppController controller, VpnDevice device) => MaterialApp(
  locale: const Locale('fr'),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  theme: FuzeVpnTheme.light(),
  home: Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: DeviceRow(device: device, controller: controller),
    ),
  ),
);

String _goldenPath(String file) =>
    const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')
    ? '../../build/reports/ui-previews/$file'
    : 'goldens/$file';

class _DeviceController extends ChangeNotifier implements VpnAppController {
  @override
  String? currentDeviceId;

  @override
  bool isRevoking = false;

  final List<VpnDevice> revocationRequests = <VpnDevice>[];

  @override
  Future<bool> revokeDevice(VpnDevice device) async {
    revocationRequests.add(device);
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UnusedApi implements VpnApiRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UnusedStore implements SecureSessionStore {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UnusedPreferences implements AppPreferenceStore {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _IdleTunnel implements VpnTunnelGateway {
  @override
  Stream<VpnRuntimeState> get states => const Stream<VpnRuntimeState>.empty();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
