import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/guest_accounts.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/features/auth/welcome_page.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';
import 'package:fuzevpn_android/widgets/notice_card.dart';

const Location _frankfurt = Location(
  id: 'frankfurt-01',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 01',
  supportedProtocols: <VpnProtocol>{VpnProtocol.wireGuard, VpnProtocol.openVpn},
);

const Location _frankfurt02 = Location(
  id: 'frankfurt-02',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 02',
  supportedProtocols: <VpnProtocol>{VpnProtocol.wireGuard, VpnProtocol.openVpn},
);

const _hierarchyCatalogue = <Location>[
  _frankfurt,
  _frankfurt02,
  Location(
    id: 'berlin-01',
    city: 'Berlin',
    countryCode: 'DE',
    displayName: 'Berlin 01',
    supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
  ),
  Location(
    id: 'paris-01',
    city: 'Paris',
    countryCode: 'FR',
    displayName: 'Paris 01',
    supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
  ),
  Location(
    id: 'montreal-01',
    city: 'Montréal',
    countryCode: 'CA',
    displayName: 'Montréal 01',
    supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
  ),
];

const UserProfile _profile = UserProfile(
  userId: 'user-test',
  email: 'client@example.test',
  firstName: 'Client',
  lastName: 'Test',
  phone: '+33600000000',
  addressLine1: '1 rue Exemple',
  addressLine2: '',
  postalCode: '75001',
  city: 'Paris',
  countryCode: 'FR',
  emailVerified: true,
);

void main() {
  setUpAll(() async {
    if (!const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')) return;
    TestWidgetsFlutterBinding.ensureInitialized();
    await (FontLoader(
      'Archivo',
    )..addFont(rootBundle.load('assets/fonts/Archivo-Variable.ttf'))).load();
    await (FontLoader(
      'Google Sans',
    )..addFont(rootBundle.load('assets/fonts/GoogleSans-Variable.ttf'))).load();
    await (FontLoader('IBM Plex Mono')
          ..addFont(rootBundle.load('assets/fonts/IBMPlexMono-Regular.ttf'))
          ..addFont(rootBundle.load('assets/fonts/IBMPlexMono-SemiBold.ttf')))
        .load();
    await (FontLoader(
      'Noto Sans Arabic',
    )..addFont(rootBundle.load('assets/fonts/NotoSansArabic.ttf'))).load();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });
  for (final code in [
    'node_unavailable',
    'server_full',
    'capacity_unavailable',
  ]) {
    testWidgets(
      'APP10 $code offers manual catalogue recovery without connection',
      (tester) async {
        final h = _UiHarness();
        addTearDown(h.close);
        h.store.session = _session;
        await h.controller.initialize();
        await h.controller.setLocale(const Locale('fr'));
        final message = ApiErrorMessages.fromFailure(
          ApiException(
            statusCode: code == 'server_full' ? 409 : 503,
            errorCode: code,
          ),
        );
        h.controller.notice = AppNotice(
          titleKey: message.titleKey,
          messageKey: message.messageKey,
          arguments: message.arguments,
          diagnosticCode: message.diagnosticCode,
        );
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        final reads = h.api.catalogueReads;
        final location = h.controller.selectedLocation;
        final refresh = find.byKey(
          const ValueKey('connection-error-refresh-locations'),
        );
        await _scrollTo(tester, refresh);
        await tester.tap(refresh);
        await tester.pumpAndSettle();
        expect(h.api.catalogueReads, reads + 1);
        expect(h.controller.selectedLocation?.id, location?.id);
        expect(h.controller.isConnecting, isFalse);
        expect(h.api.enrolledLocation, isNull);
        final choose = find.byKey(
          const ValueKey('connection-error-choose-location'),
        );
        await _scrollTo(tester, choose);
        await tester.tap(choose);
        await tester.pumpAndSettle();
        expect(h.api.enrolledLocation, isNull);
        expect(h.controller.profile?.userId, _profile.userId);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('APP10 expired session does not offer destination recovery', (
    tester,
  ) async {
    final h = _UiHarness();
    addTearDown(h.close);
    h.store.session = _session;
    await h.controller.initialize();
    h.controller.notice = const AppNotice(
      titleKey: 'notice.api.title',
      messageKey: 'notice.api.message',
      arguments: {'code': 'unauthorized'},
      diagnosticCode: 'API-HTTP-401 · unauthorized',
    );
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('connection-error-refresh-locations')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('connection-error-choose-location')),
      findsNothing,
    );
  });

  testWidgets('APP10 copy action sends only safe diagnostic reference', (
    tester,
  ) async {
    final h = _UiHarness();
    addTearDown(h.close);
    h.store.session = _session;
    await h.controller.initialize();
    h.controller.notice = const AppNotice(
      titleKey: 'notice.api.title',
      messageKey: 'notice.api.message',
      arguments: {'code': 'target_unavailable'},
      diagnosticCode: 'API-HTTP-503 · node_unavailable',
    );
    String? copied;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'Clipboard.setData') {
            copied = (call.arguments as Map)['text'] as String;
          }
          return null;
        });
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null),
    );
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    final copy = find.byKey(const ValueKey('notice-copy-reference')).first;
    await _scrollTo(tester, copy);
    await tester.tap(copy);
    await tester.pumpAndSettle();
    expect(copied, 'API-HTTP-503 · node_unavailable');
  });

  testWidgets(
    'APP10 recovery controls remain reachable at 320dp and 200 percent',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 640);
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final h = _UiHarness();
      addTearDown(h.close);
      h.store.session = _session;
      await h.controller.initialize();
      await h.controller.setLocale(const Locale('fr'));
      h.controller.notice = const AppNotice(
        titleKey: 'notice.api.title',
        messageKey: 'notice.api.message',
        arguments: {'code': 'target_unavailable'},
        diagnosticCode: 'API-HTTP-503 · node_unavailable',
      );
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      final navigationLabel = find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Emplacements'),
      );
      final labelContext = tester.element(navigationLabel);
      expect(DefaultTextStyle.of(labelContext).maxLines, 1);
      expect(DefaultTextStyle.of(labelContext).softWrap, isFalse);
      expect(DefaultTextStyle.of(labelContext).overflow, TextOverflow.ellipsis);
      final semantics = tester.ensureSemantics();
      expect(
        tester.getSemantics(navigationLabel).label,
        contains('Emplacements'),
      );
      semantics.dispose();
      await tester.runAsync(
        () => precacheImage(
          const AssetImage('assets/images/fuzevpn-emblem.png'),
          tester.element(find.byType(Scaffold).first),
        ),
      );
      await tester.pumpAndSettle();
      final notice = find.byKey(const ValueKey('connection-error-notice'));
      await _scrollTo(tester, notice);
      await Scrollable.ensureVisible(tester.element(notice), alignment: 0);
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: notice,
          matching: find.text('Serveur temporairement indisponible'),
        ),
        findsOneWidget,
      );
      if (const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')) {
        await expectLater(
          find.byType(Scaffold).first,
          matchesGoldenFile('goldens/helper-app10-error-top-320-200.png'),
        );
      }
      final choose = find.byKey(
        const ValueKey('connection-error-choose-location'),
      );
      await _scrollTo(tester, choose);
      final refresh = find.byKey(
        const ValueKey('connection-error-refresh-locations'),
      );
      await Scrollable.ensureVisible(tester.element(refresh), alignment: 0);
      await tester.pumpAndSettle();
      expect(choose.hitTestable(), findsOneWidget);
      expect(refresh.hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
      if (const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')) {
        await expectLater(
          find.byType(Scaffold).first,
          matchesGoldenFile('goldens/helper-app10-recovery-320-200.png'),
        );
      }
      tester.view.physicalSize = const Size(412, 915);
      tester.platformDispatcher.textScaleFactorTestValue = 1;
      await tester.pumpAndSettle();
      final copy = find.byKey(const ValueKey('notice-copy-reference')).first;
      await _scrollTo(tester, copy);
      if (const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')) {
        await expectLater(
          find.byType(Scaffold).first,
          matchesGoldenFile('goldens/helper-app10-recovery-412-100.png'),
        );
      }
      expect(tester.takeException(), isNull);
    },
    tags: 'golden',
  );

  testWidgets('location refresh failures are visible on the locations page', (
    WidgetTester tester,
  ) async {
    final _UiHarness h = _UiHarness();
    addTearDown(h.close);
    h.store.session = _session;
    await h.controller.initialize();
    await h.controller.setLocale(const Locale('fr'));
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Emplacements'));
    await tester.pumpAndSettle();
    h.api.locationsFailure = const ApiNetworkException();
    await h.controller.refreshLocations();
    await tester.pumpAndSettle();
    final NoticeCard notice = tester.widget<NoticeCard>(
      find.byType(NoticeCard),
    );
    expect(notice.notice, same(h.controller.notice));
    expect(notice.notice, isNotNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'hierarchy back is local to Locations and browsing makes no requests',
    (tester) async {
      final h = _UiHarness();
      addTearDown(h.close);
      h.store.session = _session;
      await h.controller.initialize();
      await h.controller.setLocale(const Locale('fr'));
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      final reads = h.api.catalogueReads;
      await tester.tap(find.text('Emplacements'));
      await tester.pumpAndSettle();
      await _openFrankfurtServers(tester);
      await _scrollTo(
        tester,
        find.byKey(const ValueKey('select-location-frankfurt-02')),
      );
      expect(
        find.byKey(const ValueKey('select-location-frankfurt-02')),
        findsOneWidget,
      );
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      await _scrollTo(
        tester,
        find.byKey(const ValueKey('browse-city-DE-frankfurt')),
      );
      expect(
        find.byKey(const ValueKey('browse-city-DE-frankfurt')),
        findsOneWidget,
      );
      final route = ModalRoute.of(tester.element(find.byType(Scaffold).first))!;
      expect(route.popDisposition, RoutePopDisposition.doNotPop);
      await tester.tap(find.text('Compte'));
      await tester.pumpAndSettle();
      expect(route.popDisposition, RoutePopDisposition.bubble);
      await tester.tap(find.text('Emplacements'));
      await tester.pumpAndSettle();
      await _scrollTo(
        tester,
        find.byKey(const ValueKey('browse-city-DE-frankfurt')),
      );
      expect(
        find.byKey(const ValueKey('browse-city-DE-frankfurt')),
        findsOneWidget,
      );
      await _scrollTo(
        tester,
        find.byKey(const ValueKey('locations-back')),
        delta: -200,
      );
      await tester.tap(find.byKey(const ValueKey('locations-back')));
      await tester.pumpAndSettle();
      await _scrollTo(tester, find.byKey(const ValueKey('browse-country-DE')));
      expect(find.byKey(const ValueKey('browse-country-DE')), findsOneWidget);
      expect(route.popDisposition, RoutePopDisposition.bubble);
      expect(h.api.catalogueReads, reads);
      expect(h.tunnel.lifecycle, isEmpty);
      expect(h.controller.selectedLocation?.id, 'frankfurt-01');
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('account shows a failure only once', (WidgetTester tester) async {
    final _UiHarness h = _UiHarness();
    addTearDown(h.close);
    h.store.session = _session;
    await h.controller.initialize();
    await h.controller.setLocale(const Locale('fr'));
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Compte'));
    await tester.pumpAndSettle();
    h.api.locationsFailure = const ApiNetworkException();
    await h.controller.refreshLocations();
    await tester.pumpAndSettle();
    expect(h.controller.notice, isNotNull);
    expect(find.byType(NoticeCard), findsOneWidget);
  });

  testWidgets(
    'connected location change confirms before stop then reconnects to the target',
    (tester) async {
      final h = _UiHarness();
      try {
        h.store.session = _session;
        await h.controller.initialize();
        await h.controller.setLocale(const Locale('fr'));
        h.tunnel.completeConnections = true;
        h.tunnel.initialState = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
          locationId: 'frankfurt-01',
        );
        h.controller.tunnelState = h.tunnel.initialState;
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        await _scrollTo(tester, find.text('Changer d’emplacement'));
        await tester.tap(find.text('Changer d’emplacement'));
        await tester.pumpAndSettle();
        await _openFrankfurtServers(tester);
        final target = find.byKey(
          const ValueKey('select-location-frankfurt-02'),
        );
        await _scrollTo(tester, target);
        await tester.tap(target);
        await tester.pumpAndSettle();
        expect(
          find.byKey(const ValueKey('location-change-dialog')),
          findsOneWidget,
        );
        expect(h.tunnel.lifecycle, isEmpty);
        await tester.tap(find.byKey(const ValueKey('location-change-cancel')));
        await tester.pumpAndSettle();
        expect(h.controller.selectedLocation?.id, 'frankfurt-01');
        expect(h.tunnel.lifecycle, isEmpty);
        await tester.tap(target);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('location-change-confirm')));
        await tester.pumpAndSettle();
        expect(h.tunnel.lifecycle, [
          'disconnect',
          'connect:wireguard:frankfurt-02',
        ]);
        expect(h.controller.isConnected, isTrue);
        expect(h.controller.selectedLocation?.id, 'frankfurt-02');
        expect(h.controller.notice, isNull);
        expect(
          find.byKey(const ValueKey('location-change-dialog')),
          findsNothing,
        );
        expect(find.text('Votre connexion'), findsOneWidget);
        expect(find.text('Changement d’emplacement prêt'), findsNothing);
        expect(tester.takeException(), isNull);
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        await h.close();
      }
    },
  );

  testWidgets(
    'password reset failure is announced in the modal and can retry',
    (WidgetTester tester) async {
      final _UiHarness h = _UiHarness();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.setLocale(const Locale('fr'));
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      await _scrollTo(tester, find.byKey(const ValueKey('welcome-sign-in')));
      await tester.tap(find.byKey(const ValueKey('welcome-sign-in')));
      await tester.pumpAndSettle();
      await _reviewScrollTo(tester, find.text('Mot de passe oublié ?'));
      await tester.tap(find.text('Mot de passe oublié ?'));
      await tester.pumpAndSettle();
      h.api.passwordResetFailure = const ApiException(
        statusCode: 429,
        errorCode: 'rate_limited',
        retryAfterSeconds: 30,
      );
      await tester.enterText(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(TextFormField),
        ),
        'client@example.test',
      );
      await tester.tap(find.text('Envoyer le lien'));
      await tester.pumpAndSettle();
      final Finder modalNotice = find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(NoticeCard),
      );
      expect(modalNotice, findsOneWidget);
      expect(tester.widget<NoticeCard>(modalNotice).notice, isNotNull);
      expect(h.controller.notice, isNull);
      h.api.passwordResetFailure = null;
      await tester.ensureVisible(find.text('Envoyer le lien'));
      await tester.tap(find.text('Envoyer le lien'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsNothing);
      expect(h.controller.notice, isNotNull);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'dismissed reset form safely returns a delayed failure to login',
    (WidgetTester tester) async {
      final _UiHarness h = _UiHarness();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.setLocale(const Locale('fr'));
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      await _scrollTo(tester, find.byKey(const ValueKey('welcome-sign-in')));
      await tester.tap(find.byKey(const ValueKey('welcome-sign-in')));
      await tester.pumpAndSettle();
      await _reviewScrollTo(tester, find.text('Mot de passe oublié ?'));
      await tester.tap(find.text('Mot de passe oublié ?'));
      await tester.pumpAndSettle();
      h.api.passwordResetRelease = Completer<void>();
      h.api.passwordResetFailure = const ApiNetworkException();
      await tester.enterText(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(TextFormField),
        ),
        'client@example.test',
      );
      await tester.tap(find.text('Envoyer le lien'));
      await tester.pump();
      Navigator.of(tester.element(find.byType(BottomSheet))).pop();
      await tester.pump(const Duration(milliseconds: 400));
      h.api.passwordResetRelease!.complete();
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsNothing);
      expect(h.controller.notice, isNotNull);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('network protection card explains the Android settings handoff', (
    tester,
  ) async {
    final h = _UiHarness();
    addTearDown(h.close);
    h.store.session = _session;
    await h.controller.initialize();
    await h.controller.setLocale(const Locale('fr'));
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Compte'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Protection réseau'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Protection réseau'), findsOneWidget);
    expect(find.text('Protection système à vérifier'), findsOneWidget);

    final info = find.byKey(const ValueKey('protection-guide-info'));
    await _scrollTo(tester, info);
    await tester.tap(info);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheet), findsOneWidget);
    expect(
      find.byKey(const ValueKey('protection-guide-scroll')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('protection-guide-warning')),
      findsOneWidget,
    );
    final openSettings = find.byKey(
      const ValueKey('protection-guide-open-settings'),
    );
    await tester.ensureVisible(openSettings);
    await tester.tap(openSettings);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheet), findsNothing);
  });

  for (final locale in ['fr', 'en', 'es', 'de']) {
    testWidgets(
      'native confirmed families restore and disappear immediately ($locale)',
      (tester) async {
        final h = _UiHarness();
        addTearDown(h.close);
        h.store.session = _session;
        h.tunnel.initialState = VpnRuntimeState.fromWire({
          'phase': 'connected',
          'protocol': 'openvpn',
          'ip_families': ['ipv4', 'ipv6'],
        });
        await h.controller.initialize();
        await h.controller.setLocale(Locale(locale));
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pump();
        await _openConnectionDetails(tester);
        expect(find.text('IPv4 + IPv6'), findsOneWidget);
        h.tunnel._states.add(
          const VpnRuntimeState(
            phase: VpnRuntimePhase.connecting,
            protocol: VpnProtocol.openVpn,
            messageCode: 'openvpn_reconnecting',
            ipFamilies: ['ipv4', 'ipv6'],
          ),
        );
        await tester.pump();
        await tester.pump();
        expect(find.byKey(const ValueKey('tunnel-ip-families')), findsNothing);
        h.tunnel._states.add(
          const VpnRuntimeState(
            phase: VpnRuntimePhase.connected,
            protocol: VpnProtocol.wireGuard,
            ipFamilies: ['ipv4'],
          ),
        );
        await tester.pump();
        await tester.pump();
        await _openConnectionDetails(tester);
        expect(find.text('IPv4'), findsOneWidget);
        h.tunnel._states.add(
          const VpnRuntimeState(phase: VpnRuntimePhase.idle),
        );
        await tester.pump();
        await tester.pump();
        expect(find.byKey(const ValueKey('tunnel-ip-families')), findsNothing);
      },
    );
  }

  for (final locale in <String, List<String>>{
    'fr': [
      'Profil OpenVPN révoqué',
      'Réessayer l’arrêt',
      'Réessayer le nettoyage',
      'Le profil OpenVPN révoqué a été supprimé. Appuyez sur Se connecter pour en créer un nouveau.',
    ],
    'en': [
      'OpenVPN profile revoked',
      'Retry shutdown',
      'Retry cleanup',
      'The revoked OpenVPN profile has been removed. Tap Connect to create a new one.',
    ],
    'es': [
      'Perfil OpenVPN revocado',
      'Reintentar detención',
      'Reintentar limpieza',
      'Se ha eliminado el perfil OpenVPN revocado. Pulse Conectar para crear uno nuevo.',
    ],
    'de': [
      'OpenVPN-Profil widerrufen',
      'Beenden erneut versuchen',
      'Bereinigung wiederholen',
      'Das widerrufene OpenVPN-Profil wurde entfernt. Tippen Sie auf Verbinden, um ein neues zu erstellen.',
    ],
  }.entries) {
    for (final stopped in [false, true]) {
      testWidgets(
        'restored OpenVPN cleanup retries without logging out (${locale.key}, stopped=$stopped)',
        (tester) async {
          final h = _UiHarness();
          addTearDown(h.close);
          h.store.session = _session;
          h.store._deviceIds['user-test'] = 'device-a';
          h.tunnel.pendingRevocation = OpenVpnRevocationResult(
            accountId: 'user-test',
            deviceId: 'device-a',
            csrSha256: 'a' * 64,
            tunnelStopped: stopped,
            stopError: stopped ? null : 'openvpn_stop_timeout',
            storageError: stopped ? 'openvpn_identity_clear_failed' : null,
          );
          await h.controller.initialize();
          await h.controller.setLocale(Locale(locale.key));
          await tester.pumpWidget(
            FuzeVpnApp(controller: h.controller, autoInitialize: false),
          );
          await tester.pumpAndSettle();
          expect(find.text(locale.value[0]), findsOneWidget);
          expect(find.byType(ChoiceChip), findsNothing);
          expect(find.byType(TextFormField), findsNothing);
          expect(h.controller.isSignedIn, isTrue);
          await tester.tap(
            find.widgetWithText(FilledButton, locale.value[stopped ? 2 : 1]),
          );
          await tester.pumpAndSettle();
          expect(h.tunnel.cleanupCalls, 1);
          expect(h.controller.openVpnRevocation, isNull);
          expect(h.controller.isSignedIn, isTrue);
          await _scrollTo(tester, find.text(locale.value[3]));
          expect(find.text(locale.value[3]), findsOneWidget);
        },
      );
    }
  }

  for (final ownMigration in [false, true]) {
    testWidgets(
      'A3 account switch removes the old migration panel (B migration=$ownMigration)',
      (tester) async {
        final h = _UiHarness();
        addTearDown(h.close);
        h.store.session = _session;
        h.store._deviceIds['user-test'] = 'device-a';
        const aMigration = DeviceLocationMigration(
          migrationId: 'migration-a',
          deviceId: 'device-a',
          sourceLocationId: 'frankfurt-01',
          targetLocationId: 'frankfurt-02',
          status: LocationMigrationStatus.blocked,
        );
        h.store.migrations['user-test/device-a'] = aMigration;
        await h.controller.initialize();
        await h.controller.setLocale(const Locale('fr'));
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        await _scrollTo(tester, find.text('Frankfurt 01 → Frankfurt 02'));
        expect(find.text('Frankfurt 01 → Frankfurt 02'), findsOneWidget);
        await h.controller.signOut();
        await tester.pumpAndSettle();
        h.api.loginSession = AuthSession(
          accessToken: 'session-b',
          expiresAt: DateTime.utc(2099),
        );
        h.api.profileResult = const UserProfile(
          userId: 'user-b',
          email: 'b@example.test',
          firstName: 'Compte',
          lastName: 'B',
          phone: '+33600000000',
          addressLine1: '1 rue Exemple',
          addressLine2: '',
          postalCode: '75001',
          city: 'Paris',
          countryCode: 'FR',
          emailVerified: true,
        );
        h.store._deviceIds['user-b'] = 'device-b';
        if (ownMigration) {
          h.store.migrations['user-b/device-b'] = const DeviceLocationMigration(
            migrationId: 'migration-b',
            deviceId: 'device-b',
            sourceLocationId: 'frankfurt-02',
            targetLocationId: 'frankfurt-01',
            status: LocationMigrationStatus.blocked,
          );
        }
        await h.controller.signIn(email: 'b@example.test', password: 'fixture');
        await tester.pumpAndSettle();
        await _scrollTo(
          tester,
          find.text(
            ownMigration ? 'Frankfurt 02 → Frankfurt 01' : 'Options avancées',
          ),
        );
        expect(find.text('Frankfurt 01 → Frankfurt 02'), findsNothing);
        expect(
          find.text('Changement d’emplacement'),
          ownMigration ? findsOneWidget : findsNothing,
        );
        if (ownMigration) {
          expect(find.text('Frankfurt 02 → Frankfurt 01'), findsOneWidget);
        }
        await tester.scrollUntilVisible(
          find.text('Options avancées'),
          250,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.tap(find.text('Options avancées'));
        await tester.pumpAndSettle();
        final protocol = find.widgetWithText(ChoiceChip, 'OpenVPN');
        expect(
          tester.widget<ChoiceChip>(protocol).onSelected,
          ownMigration ? isNull : isNotNull,
        );
        if (!ownMigration) {
          await tester.ensureVisible(protocol);
          await tester.tap(protocol);
          await tester.pump();
          expect(h.controller.selectedProtocol, VpnProtocol.openVpn);
          await tester.tap(find.text('Emplacements'));
          await tester.pumpAndSettle();
          await _openFrankfurtServers(tester);
          await _scrollTo(tester, find.text('Frankfurt 02'));
          await tester.tap(find.text('Frankfurt 02'));
          await tester.pumpAndSettle();
          await tester.tap(
            find.byKey(const ValueKey('location-change-confirm')),
          );
          await tester.pumpAndSettle();
          expect(h.controller.selectedLocation?.id, 'frankfurt-02');
        }
        expect(h.store.migrations['user-test/device-a'], same(aMigration));
      },
    );
  }

  for (final locale in <String, List<String>>{
    'fr': ['Réessayer l’arrêt', 'Réessayer le nettoyage'],
    'en': ['Retry shutdown', 'Retry cleanup'],
    'es': ['Reintentar detención', 'Reintentar limpieza'],
    'de': ['Beenden erneut versuchen', 'Bereinigung wiederholen'],
  }.entries) {
    for (final stopped in [false, true]) {
      testWidgets(
        'cleanup blocks authentication and retries (${locale.key}, stopped=$stopped)',
        (tester) async {
          final h = _UiHarness();
          addTearDown(h.close);
          h.store.session = _session;
          await h.controller.initialize();
          await h.controller.setLocale(Locale(locale.key));
          h.store.terminationResult = SessionTerminationResult(
            tunnelStopped: stopped,
            sessionCleared: !stopped,
            stopError: stopped ? null : 'openvpn_stop_timeout',
            storageError: stopped ? 'secure_storage_write_failed' : null,
          );
          await tester.pumpWidget(
            FuzeVpnApp(controller: h.controller, autoInitialize: false),
          );
          await h.controller.signOut();
          await tester.pumpAndSettle();
          expect(find.byType(TextFormField), findsNothing);
          final retry = find.widgetWithText(
            FilledButton,
            locale.value[stopped ? 1 : 0],
          );
          expect(retry, findsOneWidget);
          h.store.terminationResult = const SessionTerminationResult.complete();
          await tester.tap(retry);
          await tester.pumpAndSettle();
          expect(find.byType(WelcomePage), findsOneWidget);
          expect(h.store.clearCalls, 2);
        },
      );
    }
  }

  testWidgets(
    'cleanup takes priority over an open account dialog until confirmed',
    (tester) async {
      final h = _UiHarness();
      addTearDown(h.close);
      h.store.session = _session;
      await h.controller.initialize();
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      unawaited(
        showDialog<void>(
          context: tester.element(find.byType(Scaffold).first),
          builder: (_) =>
              const AlertDialog(content: Text('obsolete account dialog')),
        ),
      );
      await tester.pumpAndSettle();
      h.store.clearRelease = Completer<void>();
      final ending = h.controller.signOut();
      await tester.pump();
      expect(find.text('obsolete account dialog'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(TextFormField), findsNothing);
      expect(find.byType(FilledButton), findsNothing);
      h.store.clearRelease!.complete();
      await ending;
      await tester.pumpAndSettle();
      expect(find.byType(WelcomePage), findsOneWidget);
    },
  );

  testWidgets(
    'activity restoration keeps failed shutdown above authentication',
    (tester) async {
      final h = _UiHarness();
      addTearDown(h.close);
      h.tunnel.initialState = const VpnRuntimeState(
        phase: VpnRuntimePhase.error,
        sessionTermination: SessionTerminationResult(
          tunnelStopped: false,
          sessionCleared: true,
          stopError: 'wireguard_stop_timeout',
          sessionExpired: true,
        ),
      );
      await h.controller.initialize();
      await h.controller.setLocale(const Locale('fr'));
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      expect(find.text('Réessayer l’arrêt'), findsOneWidget);
      expect(find.byType(TextFormField), findsNothing);
      expect(h.store.clearCalls, 0);
      await tester.tap(find.text('Réessayer l’arrêt'));
      await tester.pumpAndSettle();
      expect(find.byType(WelcomePage), findsOneWidget);
      expect(find.text('Session expirée'), findsOneWidget);
    },
  );

  testWidgets(
    'a completed native termination restores the expired-session notice',
    (tester) async {
      final h = _UiHarness();
      addTearDown(h.close);
      h.tunnel.initialState = const VpnRuntimeState(
        phase: VpnRuntimePhase.idle,
        sessionTermination: SessionTerminationResult(
          tunnelStopped: true,
          sessionCleared: true,
          sessionExpired: true,
        ),
      );
      await h.controller.initialize();
      await h.controller.setLocale(const Locale('fr'));
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      expect(find.text('Session expirée'), findsOneWidget);
      expect(find.byType(WelcomePage), findsOneWidget);
      expect(h.store.clearCalls, 0);
    },
  );

  testWidgets(
    'a late metrics sample cannot restore the interrupted OpenVPN session',
    (WidgetTester tester) async {
      final _UiHarness harness = _UiHarness();
      addTearDown(harness.close);
      harness.store.session = _session;
      await harness.controller.initialize();
      await tester.pumpWidget(
        FuzeVpnApp(controller: harness.controller, autoInitialize: false),
      );
      harness.tunnel._states.add(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.openVpn,
        ),
      );
      await tester.pump();
      harness.tunnel.pendingState = Completer<VpnRuntimeState>();
      await tester.pump(const Duration(seconds: 1));
      harness.tunnel._states.add(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.connecting,
          protocol: VpnProtocol.openVpn,
          messageCode: 'openvpn_reconnecting',
        ),
      );
      await tester.pump();
      harness.tunnel.pendingState!.complete(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.openVpn,
          receivedBytes: 999999,
        ),
      );
      await tester.pump();
      expect(harness.controller.tunnelState.isReconnecting, isTrue);
      expect(harness.controller.tunnelState.receivedBytes, isNull);
      expect(find.byIcon(Icons.verified_user), findsNothing);
      await harness.controller.disconnect();
      await tester.pump();
    },
  );

  for (final MapEntry<String, String> locale in <String, String>{
    'fr': 'Reconnexion…',
    'en': 'Reconnecting…',
    'es': 'Reconectando…',
    'de': 'Verbindung wird wiederhergestellt…',
  }.entries) {
    testWidgets(
      'OpenVPN recovery removes protection and allows cancellation (${locale.key})',
      (WidgetTester tester) async {
        final _UiHarness harness = _UiHarness();
        addTearDown(harness.close);
        harness.store.session = _session;
        await harness.controller.initialize();
        await harness.controller.setLocale(Locale(locale.key));
        await tester.pumpWidget(
          FuzeVpnApp(controller: harness.controller, autoInitialize: false),
        );
        harness.tunnel._states.add(
          VpnRuntimeState(
            phase: VpnRuntimePhase.connected,
            protocol: VpnProtocol.openVpn,
            connectedAt: DateTime.now().subtract(const Duration(minutes: 5)),
            receivedBytes: 1048576,
            sentBytes: 2097152,
          ),
        );
        await tester.pump();
        expect(harness.controller.isConnected, isTrue);
        expect(find.byIcon(Icons.verified_user), findsOneWidget);

        harness.tunnel._states.add(
          const VpnRuntimeState(
            phase: VpnRuntimePhase.connecting,
            protocol: VpnProtocol.openVpn,
            messageCode: 'openvpn_reconnecting',
          ),
        );
        await tester.pump();
        expect(harness.controller.isConnected, isFalse);
        expect(find.byIcon(Icons.verified_user), findsNothing);
        expect(find.text(locale.value), findsOneWidget);
        expect(harness.controller.tunnelState.connectedAt, isNull);
        expect(harness.controller.tunnelState.receivedBytes, isNull);
        expect(harness.controller.tunnelState.sentBytes, isNull);
        final String cancel = <String, String>{
          'fr': 'Annuler',
          'en': 'Cancel',
          'es': 'Cancelar',
          'de': 'Abbrechen',
        }[locale.key]!;
        final Finder cancelButton = find.widgetWithText(FilledButton, cancel);
        expect(tester.widget<FilledButton>(cancelButton).onPressed, isNotNull);
        await tester.ensureVisible(cancelButton);
        await tester.tap(cancelButton);
        await tester.pump();
        expect(harness.tunnel.disconnectCalls, 1);
        expect(harness.controller.tunnelState.phase, VpnRuntimePhase.idle);
      },
    );
  }

  testWidgets('a fresh OpenVPN proof starts new duration and counters', (
    WidgetTester tester,
  ) async {
    final _UiHarness harness = _UiHarness();
    addTearDown(harness.close);
    harness.store.session = _session;
    await harness.controller.initialize();
    await harness.controller.setLocale(const Locale('fr'));
    await tester.pumpWidget(
      FuzeVpnApp(controller: harness.controller, autoInitialize: false),
    );
    harness.tunnel._states.add(
      const VpnRuntimeState(
        phase: VpnRuntimePhase.connecting,
        protocol: VpnProtocol.openVpn,
        messageCode: 'openvpn_reconnecting',
      ),
    );
    await tester.pump();
    final DateTime freshProof = DateTime.now();
    final freshState = VpnRuntimeState(
      phase: VpnRuntimePhase.connected,
      protocol: VpnProtocol.openVpn,
      connectedAt: freshProof,
      receivedBytes: 0,
      sentBytes: 0,
    );
    // The periodic native poll must agree with the new connected event while
    // the user scrolls and opens the details panel.
    harness.tunnel.initialState = freshState;
    harness.tunnel._states.add(freshState);
    await tester.pump();
    expect(harness.controller.isConnected, isTrue);
    expect(find.text('Reconnexion…'), findsNothing);
    expect(harness.controller.tunnelState.connectedAt, freshProof);
    await _openConnectionDetails(tester);
    expect(find.text('00:00:00'), findsOneWidget);
    expect(find.text('0 B'), findsNWidgets(2));
    await harness.controller.disconnect();
    await tester.pump();
  });

  testWidgets(
    'language can be chosen before sign-in on an unsupported system locale',
    (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.localesTestValue = const [Locale('fi')];
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final h = _UiHarness();
      addTearDown(h.close);
      await h.controller.initialize();
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      expect(
        AppLocalizations.of(
          tester.element(find.byType(Scaffold).first),
        ).localeName,
        'fr',
      );
      await tester.tap(find.byKey(const ValueKey('welcome-language-settings')));
      await tester.pumpAndSettle();
      final choices = tester.widgetList<ListTile>(find.byType(ListTile));
      expect(choices.map((choice) => choice.key), [
        const ValueKey('language-system'),
        ...AppLanguages.sorted.map(
          (language) => ValueKey('language-${language.tag}'),
        ),
      ]);
      final english = find.byKey(const ValueKey('language-en'));
      await tester.ensureVisible(english);
      await tester.pumpAndSettle();
      await tester.tap(english);
      await tester.pumpAndSettle();
      expect(h.preferences.locale, 'en');
      final localizations = AppLocalizations.of(
        tester.element(find.byType(Scaffold).first),
      );
      expect(localizations.localeName, 'en');
      final signIn = find.byKey(const ValueKey('welcome-sign-in'));
      await _scrollTo(tester, signIn);
      expect(signIn.hitTestable(), findsOneWidget);
      await h.controller.signIn(
        email: 'client@example.test',
        password: 'password',
      );
      await tester.pumpAndSettle();
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.locale, const Locale('en'));
      expect(h.preferences.locale, 'en');
      expect(tester.takeException(), isNull);
    },
  );

  for (final guestProfile in [
    const UserProfile(
      userId: 'guest-ui',
      identityKind: 'guest',
      profileRedacted: true,
      canManageAccount: false,
      canClaimAccount: true,
      canUseVpn: true,
      email: 'hidden@example.invalid',
      firstName: 'Hidden',
    ),
    const UserProfile(
      userId: 'registered-ui',
      identityKind: 'registered',
      profileRedacted: true,
      canManageAccount: false,
      canClaimAccount: false,
      canUseVpn: true,
      email: 'hidden@example.invalid',
      firstName: 'Hidden',
    ),
  ]) {
    testWidgets(
      'settings ${guestProfile.identityKind} conceal identity and deletion while retaining Fuze Premium',
      (tester) async {
        final h = _UiHarness();
        addTearDown(h.close);
        h.store.session = _session;
        h.api.profileResult = guestProfile;
        // Settings belong to an already activated guest, not a checkout-only
        // identity that must still see the initial welcome.
        h.store.admittedGuests.add(guestProfile.userId);
        await h.controller.initialize();
        await h.controller.setLocale(const Locale('fr'));
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Compte'));
        await tester.pumpAndSettle();
        expect(find.text('hidden@example.invalid'), findsNothing);
        expect(find.text('Hidden'), findsNothing);
        expect(
          find.byKey(const ValueKey('guest-profile-description')),
          findsOneWidget,
        );
        expect(
          find.byKey(const ValueKey('guest-create-account')),
          guestProfile.isGuest ? findsOneWidget : findsNothing,
        );
        expect(
          find.byKey(const ValueKey('account-sign-out')),
          guestProfile.isGuest ? findsNothing : findsOneWidget,
        );
        await _scrollTo(
          tester,
          find.byKey(const ValueKey('account-subscription')),
        );
        expect(
          find.byKey(const ValueKey('account-subscription')),
          findsOneWidget,
        );
        await _scrollTo(tester, find.byKey(const ValueKey('account-legal')));
        expect(find.byKey(const ValueKey('delete-account')), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }

  if (const bool.fromEnvironment('FUZEVPN_ONBOARDING_PREVIEWS')) {
    for (final dark in [false, true]) {
      testWidgets(
        'export guest settings ${dark ? 'dark' : 'light'} preview',
        (tester) async {
          tester.view.physicalSize = const Size(411, 915);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          final h = _UiHarness();
          addTearDown(h.close);
          h.store.session = _session;
          h.api.profileResult = const UserProfile(
            userId: 'guest-preview',
            identityKind: 'guest',
            profileRedacted: true,
            canManageAccount: false,
            canClaimAccount: true,
            canUseVpn: true,
          );
          h.store.admittedGuests.add('guest-preview');
          await h.controller.initialize();
          await h.controller.setLocale(const Locale('fr'));
          await h.controller.setThemeMode(
            dark ? ThemeMode.dark : ThemeMode.light,
          );
          h.controller.billing.subscription = const BillingSubscription(
            status: 'active',
            hasAccess: true,
            provider: 'google_play',
          );
          await tester.pumpWidget(
            FuzeVpnApp(controller: h.controller, autoInitialize: false),
          );
          await tester.pumpAndSettle();
          await tester.tap(find.text('Compte'));
          await tester.pumpAndSettle();
          h.controller.billing.messageKey = null;
          await tester.pumpWidget(
            FuzeVpnApp(controller: h.controller, autoInitialize: false),
          );
          await tester.pumpAndSettle();
          await _settleImages(tester);
          expect(
            find.byKey(const ValueKey('guest-create-account')),
            findsOneWidget,
          );
          expect(find.byKey(const ValueKey('delete-account')), findsNothing);
          expect(tester.takeException(), isNull);
          await expectLater(
            find.byType(FuzeVpnApp),
            matchesGoldenFile(
              '../../build/reports/welcome-guest-2026-10-04/previews/guest-settings-${dark ? 'dark' : 'light'}.png',
            ),
          );
        },
        tags: 'onboarding-preview',
      );
    }
  }

  testWidgets('delete account exposes the documented public request', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(412, 915);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final opened = <String>[];
    const launcher = MethodChannel('plugins.flutter.io/url_launcher');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(launcher, (
      call,
    ) async {
      if (call.method == 'launch') {
        opened.add((call.arguments as Map)['url'] as String);
        return false;
      }
      return null;
    });
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        launcher,
        null,
      ),
    );
    final h = _UiHarness();
    addTearDown(h.close);
    h.store.session = _session;
    await h.controller.initialize();
    await h.controller.setLocale(const Locale('fr'));
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Compte').last);
    await tester.pumpAndSettle();
    final deletion = find.byKey(const ValueKey('delete-account'));
    await _scrollTo(tester, deletion);
    expect(find.text('Supprimer mon compte'), findsOneWidget);
    if (const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')) {
      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('account_legal.png')),
      );
    }
    await tester.tap(deletion);
    await tester.pumpAndSettle();
    expect(opened, isEmpty);
    final warning = find.byKey(const ValueKey('delete-account-warning'));
    expect(warning, findsOneWidget);
    final warningContext = tester.element(warning);
    expect(
      find.text(warningContext.billingDeleteAccountWarning),
      findsOneWidget,
    );
    final proceed = find.byKey(const ValueKey('delete-account-continue'));
    expect(
      find.text(warningContext.billingDeleteAccountContinue),
      findsOneWidget,
    );
    await tester.ensureVisible(proceed);
    await tester.tap(proceed);
    await tester.pumpAndSettle();
    expect(warning, findsNothing);
    expect(opened, ['https://fuzevpn.com/fr/privacy.html#rights-deletion']);
    expect(find.byKey(const ValueKey('copy-external-link')), findsOneWidget);
    if (const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')) {
      await expectLater(
        find.byType(AlertDialog),
        matchesGoldenFile(_goldenPath('account_legal_link_failure.png')),
      );
    }
    expect(h.controller.isSignedIn, isTrue);
    expect(h.store.session, isNotNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets('cancel account deletion preserves the Play subscription', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(412, 915);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final opened = <String>[];
    const launcher = MethodChannel('plugins.flutter.io/url_launcher');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(launcher, (
      call,
    ) async {
      if (call.method == 'launch') {
        opened.add((call.arguments as Map)['url'] as String);
        return true;
      }
      return null;
    });
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        launcher,
        null,
      ),
    );
    final h = _UiHarness();
    addTearDown(h.close);
    h.store.session = _session;
    await h.controller.initialize();
    await h.controller.setLocale(const Locale('fr'));
    const subscription = BillingSubscription(
      status: 'active',
      hasAccess: true,
      provider: 'google_play',
    );
    h.controller.billing.subscription = subscription;
    final tunnelLifecycle = List<String>.of(h.tunnel.lifecycle);
    final disconnectCalls = h.tunnel.disconnectCalls;
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Compte').last);
    await tester.pumpAndSettle();
    final deletion = find.byKey(const ValueKey('delete-account'));
    await _scrollTo(tester, deletion);
    await tester.tap(deletion);
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('delete-account-warning')),
      findsOneWidget,
    );
    expect(opened, isEmpty);
    final cancel = find.byKey(const ValueKey('delete-account-cancel'));
    await tester.ensureVisible(cancel);
    await tester.tap(cancel);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('delete-account-warning')), findsNothing);
    expect(opened, isEmpty);
    expect(h.controller.billing.subscription, same(subscription));
    expect(h.controller.isSignedIn, isTrue);
    expect(h.store.session, same(_session));
    expect(h.tunnel.lifecycle, tunnelLifecycle);
    expect(h.tunnel.disconnectCalls, disconnectCalls);
    expect(tester.takeException(), isNull);
  });

  for (final hasPlaySubscription in [true, false]) {
    testWidgets(
      'account deletion continues after failed Play management with '
      '${hasPlaySubscription ? 'Google Play' : 'unknown'} provider and unavailable billing',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(412, 915);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        const playUrl =
            'https://play.google.com/store/account/subscriptions?sku=premium&package=com.fuzevpn';
        const deletionUrl =
            'https://fuzevpn.com/fr/privacy.html#rights-deletion';
        final opened = <String>[];
        const launcher = MethodChannel('plugins.flutter.io/url_launcher');
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          launcher,
          (call) async {
            if (call.method == 'launch') {
              final arguments = call.arguments as Map;
              final url = arguments['url'] as String;
              opened.add(url);
              expect(arguments['useWebView'], isFalse);
              if (url == playUrl) {
                if (hasPlaySubscription) {
                  throw PlatformException(code: 'unavailable');
                }
                return false;
              }
              return true;
            }
            return null;
          },
        );
        addTearDown(
          () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            launcher,
            null,
          ),
        );
        final h = _UiHarness();
        addTearDown(h.close);
        h.store.session = _session;
        await h.controller.initialize();
        await h.controller.setLocale(const Locale('fr'));
        await h.controller.billing.refreshSubscription();
        expect(h.controller.billing.messageKey, 'billing.comingSoon');
        expect(h.controller.billing.subscription, isNull);
        if (hasPlaySubscription) {
          h.controller.billing.subscription = const BillingSubscription(
            status: 'active',
            hasAccess: true,
            provider: 'google_play',
          );
        }
        final subscription = h.controller.billing.subscription;
        final tunnelLifecycle = List<String>.of(h.tunnel.lifecycle);
        final disconnectCalls = h.tunnel.disconnectCalls;
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Compte').last);
        await tester.pumpAndSettle();
        final deletion = find.byKey(const ValueKey('delete-account'));
        await _scrollTo(tester, deletion);
        await tester.tap(deletion);
        await tester.pumpAndSettle();
        final warning = find.byKey(const ValueKey('delete-account-warning'));
        expect(warning, findsOneWidget);
        expect(opened, isEmpty);
        final manage = find.byKey(const ValueKey('delete-account-manage-play'));
        await tester.ensureVisible(manage);
        await tester.tap(manage);
        await tester.pumpAndSettle();
        expect(opened, [playUrl]);
        expect(warning, findsOneWidget);
        expect(
          find.byKey(const ValueKey('copy-external-link')),
          findsOneWidget,
        );
        final closeLabel = MaterialLocalizations.of(
          tester.element(find.byKey(const ValueKey('copy-external-link'))),
        ).closeButtonLabel;
        await tester.tap(find.widgetWithText(TextButton, closeLabel));
        await tester.pumpAndSettle();
        expect(find.byKey(const ValueKey('copy-external-link')), findsNothing);
        expect(warning, findsOneWidget);
        final proceed = find.byKey(const ValueKey('delete-account-continue'));
        await tester.ensureVisible(proceed);
        await tester.tap(proceed);
        await tester.pumpAndSettle();
        expect(opened, [playUrl, deletionUrl]);
        expect(warning, findsNothing);
        expect(h.controller.billing.subscription, same(subscription));
        expect(h.controller.billing.messageKey, 'billing.comingSoon');
        expect(h.controller.isSignedIn, isTrue);
        expect(h.store.session, same(_session));
        expect(h.tunnel.lifecycle, tunnelLifecycle);
        expect(h.tunnel.disconnectCalls, disconnectCalls);
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final language in AppLanguages.all) {
    testWidgets(
      'account deletion warning fits ${language.tag} at 320dp and 200% text',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(320, 640);
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        final opened = <String>[];
        const launcher = MethodChannel('plugins.flutter.io/url_launcher');
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          launcher,
          (call) async {
            if (call.method == 'launch') {
              opened.add((call.arguments as Map)['url'] as String);
              return true;
            }
            return null;
          },
        );
        addTearDown(
          () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            launcher,
            null,
          ),
        );
        final h = _UiHarness();
        addTearDown(h.close);
        h.store.session = _session;
        h.preferences.locale = language.tag;
        await h.controller.initialize();
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        final copy = AppLocalizations.of(
          tester.element(find.byType(Scaffold).first),
        );
        await _selectReviewDestination(tester, copy.nav_account);
        final deletion = find.byKey(const ValueKey('delete-account'));
        await _scrollTo(tester, deletion);
        await tester.tap(deletion);
        await tester.pumpAndSettle();
        final warning = find.byKey(const ValueKey('delete-account-warning'));
        expect(warning, findsOneWidget);
        final context = tester.element(warning);
        expect(Localizations.localeOf(context), language.locale);
        expect(MediaQuery.sizeOf(context).width, 320);
        expect(MediaQuery.textScalerOf(context).scale(16), 32);
        expect(find.text(context.billingDeleteAccountWarning), findsOneWidget);
        expect(opened, isEmpty);
        final proceed = find.byKey(const ValueKey('delete-account-continue'));
        await tester.ensureVisible(proceed);
        await tester.pumpAndSettle();
        expect(proceed.hitTestable(), findsOneWidget);
        expect(tester.widget<FilledButton>(proceed).onPressed, isNotNull);
        final cancel = find.byKey(const ValueKey('delete-account-cancel'));
        await tester.ensureVisible(cancel);
        await tester.pumpAndSettle();
        expect(cancel.hitTestable(), findsOneWidget);
        expect(tester.widget<TextButton>(cancel).onPressed, isNotNull);
        expect(tester.takeException(), isNull);
        await tester.tap(cancel);
        await tester.pumpAndSettle();
        expect(warning, findsNothing);
        expect(opened, isEmpty);
        await tester.tap(deletion);
        await tester.pumpAndSettle();
        await tester.ensureVisible(proceed);
        await tester.pumpAndSettle();
        expect(proceed.hitTestable(), findsOneWidget);
        await tester.tap(proceed);
        await tester.pumpAndSettle();
        final publicLanguage =
            const {
              'fr',
              'en',
              'es',
              'de',
            }.contains(language.locale.languageCode)
            ? language.locale.languageCode
            : 'fr';
        expect(opened, [
          'https://fuzevpn.com/$publicLanguage/privacy.html#rights-deletion',
        ]);
        expect(warning, findsNothing);
        expect(h.controller.isSignedIn, isTrue);
        expect(h.store.session, same(_session));
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'account deletion warning stays within 560dp on a wide display at 200% text',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1920, 1080);
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final h = _UiHarness();
      addTearDown(h.close);
      h.store.session = _session;
      h.preferences.locale = 'fr';
      await h.controller.initialize();
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      final copy = AppLocalizations.of(
        tester.element(find.byType(Scaffold).first),
      );
      await _selectReviewDestination(tester, copy.nav_account);
      final deletion = find.byKey(const ValueKey('delete-account'));
      await _scrollTo(tester, deletion);
      await tester.tap(deletion);
      await tester.pumpAndSettle();
      final warning = find.byKey(const ValueKey('delete-account-warning'));
      expect(warning, findsOneWidget);
      final context = tester.element(warning);
      expect(MediaQuery.sizeOf(context), const Size(1920, 1080));
      expect(MediaQuery.textScalerOf(context).scale(16), 32);
      expect(find.text(context.billingDeleteAccountWarning), findsOneWidget);
      final panel = find.descendant(
        of: warning,
        matching: find.byWidgetPredicate(
          (widget) => widget is Material && widget.type == MaterialType.card,
        ),
      );
      expect(panel, findsOneWidget);
      expect(tester.getSize(panel).width, lessThanOrEqualTo(560));
      for (final key in [
        'delete-account-manage-play',
        'delete-account-continue',
        'delete-account-cancel',
      ]) {
        final button = find.byKey(ValueKey(key));
        await tester.ensureVisible(button);
        await tester.pumpAndSettle();
        expect(button.hitTestable(), findsOneWidget, reason: key);
        expect(
          tester.widget<ButtonStyleButton>(button).onPressed,
          isNotNull,
          reason: key,
        );
      }
      expect(tester.takeException(), isNull);
      await tester.tap(find.byKey(const ValueKey('delete-account-cancel')));
      await tester.pumpAndSettle();
      expect(warning, findsNothing);
      expect(h.controller.isSignedIn, isTrue);
      expect(h.store.session, same(_session));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'bundled font and native licenses are included in the consultable registry',
    (tester) async {
      final h = _UiHarness();
      addTearDown(h.close);
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      final entries = await tester.runAsync(
        () => LicenseRegistry.licenses.toList(),
      );
      final packages = entries!.expand((entry) => entry.packages).toSet();
      expect(
        packages,
        containsAll(<String>[
          'Archivo',
          'IBM Plex Mono',
          'Noto Sans Arabic',
          'OpenVPN 3 Core',
          'OpenSSL',
          'WireGuard Android tunnel library',
          'wireguard-go',
          'wireguard-tools',
          'Asio',
          'fmt',
          'LZ4',
          'Go runtime',
          'golang.org/x/crypto',
          'golang.org/x/net',
          'golang.org/x/sys',
        ]),
      );
      for (final name in <String>[
        'OpenSSL',
        'wireguard-tools',
        'wireguard-go',
        'Noto Sans Arabic',
      ]) {
        final entry = entries.singleWhere(
          (entry) => entry.packages.contains(name),
        );
        expect(
          entry.paragraphs.map((paragraph) => paragraph.text).join('\n').length,
          greaterThan(500),
        );
      }
      expect(tester.takeException(), isNull);
    },
  );

  group('parcours widgets Android en français', () {
    testWidgets('affiche la connexion puis le formulaire d’inscription', (
      WidgetTester tester,
    ) async {
      final _UiHarness harness = _UiHarness();
      addTearDown(harness.close);
      await harness.controller.initialize();
      await harness.controller.setLocale(const Locale('fr'));

      await tester.pumpWidget(_legacyAuthentication(harness.controller));

      expect(find.text('FuzeVPN'), findsOneWidget);
      expect(find.text('Connexion'), findsOneWidget);
      expect(find.text('Inscription'), findsOneWidget);
      expect(find.text('Adresse e-mail'), findsOneWidget);
      expect(find.text('Se connecter'), findsOneWidget);

      await tester.tap(find.text('Inscription'));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Créez votre compte en trois étapes.'), findsOneWidget);
      expect(find.text('Compte'), findsOneWidget);
      expect(find.text('Étape 1 sur 3'), findsOneWidget);
      expect(find.text('Continuer'), findsOneWidget);
      expect(find.text('conditions d’utilisation'), findsNothing);
    });

    testWidgets(
      'la connexion simulée mène à l’accueil et permet de choisir OpenVPN',
      (WidgetTester tester) async {
        final _UiHarness harness = _UiHarness();
        addTearDown(harness.close);
        await harness.controller.initialize();
        await harness.controller.setLocale(const Locale('fr'));

        await tester.pumpWidget(
          FuzeVpnApp(controller: harness.controller, autoInitialize: false),
        );
        await tester.tap(find.byKey(const ValueKey('welcome-sign-in')));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byType(TextFormField).at(0),
          'client@example.test',
        );
        await tester.enterText(
          find.byType(TextFormField).at(1),
          'mot-de-passe',
        );
        final submit = find.byKey(const ValueKey('auth-login-submit'));
        await _scrollTo(tester, submit);
        expect(submit.hitTestable(), findsOneWidget);
        await tester.tap(submit);
        await tester.pumpAndSettle();

        expect(harness.api.loginEmails, <String>['client@example.test']);
        expect(find.text('Votre connexion'), findsOneWidget);
        expect(find.text('Déconnecté'), findsOneWidget);
        expect(find.text('Frankfurt'), findsOneWidget);
        expect(find.text('Allemagne'), findsOneWidget);

        await _scrollTo(tester, find.text('Options avancées'));
        await tester.tap(find.text('Options avancées'));
        await tester.pumpAndSettle();

        expect(find.text('WireGuard'), findsOneWidget);
        expect(find.text('OpenVPN'), findsOneWidget);

        await tester.tap(find.text('OpenVPN'));
        await tester.pump();

        expect(harness.controller.selectedProtocol, VpnProtocol.openVpn);

        await tester.tap(find.text('Emplacements'));
        await tester.pump();

        expect(find.text('Emplacements'), findsAtLeastNWidgets(2));
        expect(find.text('Allemagne'), findsOneWidget);
        expect(find.text('Frankfurt 01'), findsNothing);
        expect(find.byKey(const ValueKey('locations-search')), findsOneWidget);
        await _openFrankfurtServers(tester);

        await _scrollTo(tester, find.text('Frankfurt 02'));
        await tester.tap(find.text('Frankfurt 02'));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('location-change-confirm')));
        await tester.pumpAndSettle();
        await _scrollTo(tester, find.text('Votre connexion'), delta: -200);

        expect(find.text('Votre connexion'), findsOneWidget);
        expect(find.text('Frankfurt'), findsOneWidget);
        expect(find.text('Allemagne'), findsOneWidget);
        expect(harness.controller.selectedLocation?.id, 'frankfurt-02');
      },
    );

    testWidgets(
      'autorise la déconnexion dès la preuve native même si la connexion se finalise',
      (WidgetTester tester) async {
        final _UiHarness harness = _UiHarness();
        addTearDown(harness.close);
        harness.store.session = _session;
        await harness.controller.initialize();
        await harness.controller.setLocale(const Locale('fr'));
        harness.controller.isConnecting = true;

        await tester.pumpWidget(
          FuzeVpnApp(controller: harness.controller, autoInitialize: false),
        );
        harness.controller.tunnelState = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
        );
        harness.controller.notifyListeners();
        await tester.pump();

        final Finder disconnectButton = find.widgetWithText(
          FilledButton,
          'Se déconnecter',
        );
        expect(disconnectButton, findsOneWidget);
        expect(
          tester.widget<FilledButton>(disconnectButton).onPressed,
          isNotNull,
        );

        await tester.tap(disconnectButton);
        await tester.pump();
        expect(harness.tunnel.disconnectCalls, 1);
      },
    );

    testWidgets('affiche les métriques locales du tunnel WireGuard', (
      WidgetTester tester,
    ) async {
      final _UiHarness harness = _UiHarness();
      addTearDown(harness.close);
      harness.store.session = _session;
      await harness.controller.initialize();
      await harness.controller.setLocale(const Locale('fr'));
      final DateTime now = DateTime.now();
      harness.controller.tunnelState = VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
        connectedAt: now.subtract(const Duration(seconds: 65)),
        locationId: 'frankfurt-02',
        locationName: 'Frankfurt 02',
        receivedBytes: 1536,
        sentBytes: 2048,
        latestHandshake: now.subtract(const Duration(seconds: 5)),
      );

      await tester.pumpWidget(
        FuzeVpnApp(controller: harness.controller, autoInitialize: false),
      );

      await _openConnectionDetails(tester);
      expect(find.text('Emplacement actif'), findsOneWidget);
      expect(find.text('Frankfurt 02'), findsOneWidget);
      expect(find.text('Durée'), findsOneWidget);
      expect(find.textContaining('00:01:'), findsOneWidget);
      expect(find.text('Reçus'), findsOneWidget);
      expect(find.text('1.5 KiB'), findsOneWidget);
      expect(find.text('Envoyés'), findsOneWidget);
      expect(find.text('2.0 KiB'), findsOneWidget);
      expect(find.text('Dernier échange sécurisé'), findsOneWidget);
      expect(find.textContaining('Il y a 00:00:'), findsOneWidget);
    });

    testWidgets(
      'affiche la progression et désactive la connexion pendant migration',
      (WidgetTester tester) async {
        final _UiHarness harness = _UiHarness(migrationMaxPollAttempts: 1);
        addTearDown(harness.close);
        harness.store.session = _session;
        harness.store._deviceIds['user-test'] = 'device-test';
        harness.store.migrations['user-test/device-test'] =
            const DeviceLocationMigration(
              migrationId: 'migration-test',
              deviceId: 'device-test',
              sourceLocationId: 'frankfurt-01',
              targetLocationId: 'frankfurt-02',
              status: LocationMigrationStatus.draining,
              retryAfterSeconds: 7,
            );

        harness.api.migrationResult = harness.store.migrations.values.single;
        await harness.controller.initialize();
        await tester.pump();
        await harness.controller.setLocale(const Locale('fr'));
        await tester.pumpWidget(
          FuzeVpnApp(controller: harness.controller, autoInitialize: false),
        );

        final Finder button = find.widgetWithText(
          FilledButton,
          'Changement d’emplacement…',
        );
        expect(button, findsOneWidget);
        expect(tester.widget<FilledButton>(button).onPressed, isNull);
        await _scrollTo(
          tester,
          find.text('Changement d’emplacement'),
          settle: false,
        );
        expect(find.text('Changement d’emplacement'), findsOneWidget);
        expect(find.text('Frankfurt 01 → Frankfurt 02'), findsOneWidget);
        expect(
          find.text('Préparation du changement d’emplacement…'),
          findsOneWidget,
        );
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
        expect(
          find.text('Délai entre deux vérifications : 7 s.'),
          findsOneWidget,
        );
        expect(find.text('Reprendre le changement'), findsOneWidget);
      },
    );

    testWidgets('garde l’action VPN visible à 360 × 640', (
      WidgetTester tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(360, 640);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final _UiHarness harness = _UiHarness();
      addTearDown(harness.close);
      harness.store.session = _session;
      await harness.controller.initialize();
      await harness.controller.setLocale(const Locale('fr'));

      await tester.pumpWidget(
        FuzeVpnApp(controller: harness.controller, autoInitialize: false),
      );

      final Finder connectButton = find.widgetWithText(
        FilledButton,
        'Se connecter',
      );
      expect(connectButton, findsOneWidget);
      expect(tester.getBottomRight(connectButton).dy, lessThan(560));
      expect(tester.takeException(), isNull);
    });

    for (final double width in <double>[720, 840]) {
      testWidgets('utilise une navigation latérale à ${width.toInt()} dp', (
        WidgetTester tester,
      ) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = Size(width, 960);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        final _UiHarness harness = _UiHarness();
        addTearDown(harness.close);
        harness.store.session = _session;
        await harness.controller.initialize();
        await harness.controller.setLocale(const Locale('fr'));

        await tester.pumpWidget(
          FuzeVpnApp(controller: harness.controller, autoInitialize: false),
        );

        expect(find.byType(NavigationRail), findsOneWidget);
        expect(find.byType(NavigationBar), findsNothing);
        expect(find.text('Connexion'), findsOneWidget);
        expect(find.text('Emplacements'), findsOneWidget);
        expect(find.text('Compte'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('reste sans débordement sur la matrice responsive complète', (
      WidgetTester tester,
    ) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      tester.view.devicePixelRatio = 1;

      const List<Size> sizes = <Size>[
        Size(320, 640),
        Size(360, 640),
        Size(412, 915),
        Size(600, 960),
        Size(840, 1200),
      ];
      for (final Size size in sizes) {
        for (final String theme in <String>['light', 'dark']) {
          for (final double textScale in <double>[1, 1.3, 2]) {
            tester.view.physicalSize = size;
            tester.platformDispatcher.textScaleFactorTestValue = textScale;
            final _UiHarness harness = _UiHarness();
            harness.store.session = _session;
            harness.preferences.themeMode = theme;
            await harness.controller.initialize();
            await harness.controller.setLocale(const Locale('fr'));

            await tester.pumpWidget(
              FuzeVpnApp(controller: harness.controller, autoInitialize: false),
            );
            await tester.pump();

            expect(
              tester.takeException(),
              isNull,
              reason:
                  '${size.width.toInt()}×${size.height.toInt()}, '
                  '$theme, texte ${(textScale * 100).round()} %',
            );
            expect(find.text('FuzeVPN'), findsOneWidget);

            await tester.pumpWidget(const SizedBox.shrink());
            await harness.close();
          }
        }
      }
    });

    testWidgets('golden authentification', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(412, 915);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final _UiHarness harness = _UiHarness();
      addTearDown(harness.close);
      await harness.controller.initialize();
      await harness.controller.setLocale(const Locale('fr'));

      await tester.pumpWidget(_legacyAuthentication(harness.controller));
      await tester.pumpAndSettle();

      // Wait for both the emblem and Google icon on a cold image cache.
      // pumpAndSettle alone does not await asset decoding.
      await _settleImages(tester);
      final decodedImages = tester.widgetList<RawImage>(find.byType(RawImage));
      expect(decodedImages.length, 2);
      expect(decodedImages.every((image) => image.image != null), isTrue);

      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('authentication.png')),
      );
    }, tags: 'golden');

    testWidgets('golden connexion initiale annulable', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(412, 915);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final harness = _UiHarness();
      addTearDown(harness.close);
      harness.store.session = _session;
      await harness.controller.initialize();
      await harness.controller.setLocale(const Locale('fr'));
      await harness.controller.selectProtocol(VpnProtocol.openVpn);
      harness.controller.isConnecting = true;
      harness.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.preparing,
        protocol: VpnProtocol.openVpn,
      );
      await tester.pumpWidget(
        FuzeVpnApp(controller: harness.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      await _settleImages(tester);
      final cancel = find.widgetWithText(FilledButton, 'Annuler');
      expect(cancel.hitTestable(), findsOneWidget);
      expect(tester.widget<FilledButton>(cancel).onPressed, isNotNull);
      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('connection_preparing_cancel.png')),
      );
      await tester.tap(cancel);
      await tester.pumpAndSettle();
      expect(harness.controller.isConnecting, isFalse);
      expect(harness.controller.tunnelState.phase, VpnRuntimePhase.idle);
      expect(harness.tunnel.disconnectCalls, 1);
      expect(tester.takeException(), isNull);
    }, tags: 'golden');

    testWidgets('goldens connexion déconnectée et connectée', (
      WidgetTester tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(412, 915);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final _UiHarness harness = _UiHarness();
      addTearDown(harness.close);
      harness.store.session = _session;
      await harness.controller.initialize();
      await harness.controller.setLocale(const Locale('fr'));

      await tester.pumpWidget(
        FuzeVpnApp(controller: harness.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      await _settleImages(tester);
      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('connection_disconnected.png')),
      );

      harness.preferences.themeMode = 'dark';
      await harness.controller.setThemeMode(ThemeMode.dark);
      harness.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
        locationId: 'frankfurt-01',
        locationName: 'Frankfurt 01',
      );
      harness.controller.notifyListeners();
      await tester.pumpAndSettle();
      await _settleImages(tester);
      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('connection_connected_dark.png')),
      );
    }, tags: 'golden');

    testWidgets('goldens emplacements et compte', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(412, 915);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final _UiHarness harness = _UiHarness();
      harness.api.catalogue = _hierarchyCatalogue;
      addTearDown(harness.close);
      harness.store.session = _session;
      await harness.controller.initialize();
      await harness.controller.setLocale(const Locale('fr'));

      await tester.pumpWidget(
        FuzeVpnApp(controller: harness.controller, autoInitialize: false),
      );
      await tester.tap(find.text('Emplacements'));
      await tester.pumpAndSettle();
      await _settleImages(tester);
      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('locations.png')),
      );

      await tester.tap(find.byKey(const ValueKey('browse-country-DE')));
      await tester.pumpAndSettle();
      await _settleImages(tester);
      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('locations_cities.png')),
      );
      await _scrollTo(
        tester,
        find.byKey(const ValueKey('browse-city-DE-frankfurt')),
      );
      await tester.tap(find.byKey(const ValueKey('browse-city-DE-frankfurt')));
      await tester.pumpAndSettle();
      await _settleImages(tester);
      expect(
        find.byKey(const ValueKey('select-location-frankfurt-01')),
        findsOneWidget,
      );
      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('locations_servers.png')),
      );
      await tester.enterText(
        find.byKey(const ValueKey('locations-search')),
        'Frankfurt',
      );
      await tester.pumpAndSettle();
      await _settleImages(tester);
      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('locations_search.png')),
      );

      await tester.tap(find.text('Compte'));
      await tester.pumpAndSettle();
      await _settleImages(tester);
      await expectLater(
        find.byType(Scaffold).first,
        matchesGoldenFile(_goldenPath('account.png')),
      );
    }, tags: 'golden');

    testWidgets('goldens confirmation et guide Android', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(412, 915);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final harness = _UiHarness();
      addTearDown(harness.close);
      harness.store.session = _session;
      await harness.controller.initialize();
      await harness.controller.setLocale(const Locale('fr'));
      harness.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
        locationId: 'frankfurt-01',
      );
      await tester.pumpWidget(
        FuzeVpnApp(controller: harness.controller, autoInitialize: false),
      );
      await tester.tap(find.text('Emplacements'));
      await tester.pumpAndSettle();
      await _openFrankfurtServers(tester);
      await tester.tap(
        find.byKey(const ValueKey('select-location-frankfurt-02')),
      );
      await tester.pumpAndSettle();
      await _settleImages(tester);
      await expectLater(
        find.byType(FuzeVpnApp),
        matchesGoldenFile(_goldenPath('location_change_confirmation.png')),
      );
      await tester.tap(find.byKey(const ValueKey('location-change-cancel')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Compte'));
      await tester.pumpAndSettle();
      final info = find.byKey(const ValueKey('protection-guide-info'));
      await _scrollTo(tester, info);
      await tester.tap(info);
      await tester.pumpAndSettle();
      await _settleImages(tester);
      await expectLater(
        find.byType(FuzeVpnApp),
        matchesGoldenFile(_goldenPath('android_protection_guide.png')),
      );
      await tester.ensureVisible(
        find.byKey(const ValueKey('protection-guide-open-settings')),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(FuzeVpnApp),
        matchesGoldenFile(_goldenPath('android_protection_guide_steps.png')),
      );
      expect(tester.takeException(), isNull);
    }, tags: 'golden');

    testWidgets('goldens inscription complète et réinitialisation', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(412, 915);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final h = _UiHarness();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.setLocale(const Locale('fr'));
      await tester.pumpWidget(_legacyAuthentication(h.controller));
      await tester.pumpAndSettle();
      await _reviewScrollTo(tester, find.text('Inscription'));
      await tester.tap(find.text('Inscription'));
      await tester.pumpAndSettle();
      expect(find.text('Compte'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      await _reviewScrollTo(tester, find.byType(TabBar));
      await _captureReview(tester, 'registration_account.png');

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'client@example.test',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'mot-de-passe-solide',
      );
      await _reviewScrollTo(tester, find.text('Continuer'));
      await tester.tap(find.text('Continuer'));
      await tester.pumpAndSettle();
      expect(find.text('Identité'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      await _reviewScrollTo(tester, find.byType(TabBar));
      await _captureReview(tester, 'registration_identity.png');

      await tester.enterText(find.byType(TextFormField).at(0), 'Camille');
      await tester.enterText(find.byType(TextFormField).at(1), 'Martin');
      await tester.enterText(find.byType(TextFormField).at(2), '+33612345678');
      await _reviewScrollTo(tester, find.text('Continuer'));
      await tester.tap(find.text('Continuer'));
      await tester.pumpAndSettle();
      expect(find.text('Adresse et accords'), findsOneWidget);
      await _reviewScrollTo(tester, find.byType(TabBar));
      await _captureReview(tester, 'registration_address.png');
      await _reviewScrollTo(
        tester,
        find.byKey(const ValueKey('registration-terms-consent')),
      );
      expect(find.byType(Checkbox), findsNWidgets(2));
      expect(
        tester
            .widgetList<Checkbox>(find.byType(Checkbox))
            .every((checkbox) => checkbox.value == false),
        isTrue,
      );
      await _captureReview(tester, 'registration_agreements.png');

      await _reviewScrollTo(
        tester,
        find.descendant(
          of: find.byType(TabBar),
          matching: find.text('Connexion'),
        ),
      );
      await tester.tap(
        find.descendant(
          of: find.byType(TabBar),
          matching: find.text('Connexion'),
        ),
      );
      await tester.pumpAndSettle();
      await _reviewScrollTo(tester, find.text('Mot de passe oublié ?'));
      await tester.tap(find.text('Mot de passe oublié ?'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      await _captureReview(
        tester,
        'password_reset.png',
        wholeApplication: true,
      );
      h.api.passwordResetFailure = const ApiException(
        statusCode: 429,
        errorCode: 'rate_limited',
        retryAfterSeconds: 30,
      );
      await tester.enterText(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(TextFormField),
        ),
        'client@example.test',
      );
      await tester.ensureVisible(find.text('Envoyer le lien'));
      await tester.tap(find.text('Envoyer le lien'));
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(NoticeCard),
        ),
        findsOneWidget,
      );
      await _captureReview(
        tester,
        'password_reset_error.png',
        wholeApplication: true,
      );
      expect(h.api.loginEmails, isEmpty);
      expect(h.store.session, isNull);
      Navigator.of(tester.element(find.byType(BottomSheet))).pop();
      await tester.pumpAndSettle();
    }, tags: 'golden');

    testWidgets('goldens appareils réglages et diagnostics', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(412, 915);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final h = _UiHarness();
      addTearDown(h.close);
      h.store.session = _session;
      h.api.enrolledLocation = _frankfurt;
      await h.store.writeCurrentDeviceId(
        userId: _profile.userId,
        deviceId: 'device-test',
      );
      await h.controller.initialize();
      await h.controller.setLocale(const Locale('fr'));
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      await _selectReviewDestination(tester, 'Compte');
      final devices = find.byKey(const ValueKey('account-devices'));
      await _reviewScrollTo(tester, devices);
      expect(devices.hitTestable(), findsOneWidget);
      await tester.tap(devices);
      await tester.pumpAndSettle();
      expect(find.text('Test Android'), findsOneWidget);
      await _reviewScrollTo(
        tester,
        find.byKey(const ValueKey('account-devices')),
      );
      await _captureReview(tester, 'account_devices.png');
      await _reviewScrollTo(
        tester,
        find.byKey(const ValueKey('appearance-settings')),
      );
      await _captureReview(tester, 'account_preferences.png');
      await tester.tap(find.byKey(const ValueKey('appearance-settings')));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.byKey(const ValueKey('theme-dark')), findsOneWidget);
      await _captureReview(
        tester,
        'appearance_sheet.png',
        wholeApplication: true,
      );
      Navigator.of(tester.element(find.byType(BottomSheet))).pop();
      await tester.pumpAndSettle();
      await _reviewScrollTo(
        tester,
        find.byKey(const ValueKey('open-diagnostics')),
      );
      await tester.tap(find.byKey(const ValueKey('open-diagnostics')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('diagnostics-page')), findsOneWidget);
      expect(
        tester
            .widget<CheckboxListTile>(
              find.byKey(const ValueKey('diagnostics-send-report')),
            )
            .value,
        isFalse,
      );
      await _captureReview(tester, 'diagnostics.png');
      await h.controller.setThemeMode(ThemeMode.dark);
      await tester.pumpAndSettle();
      await _captureReview(tester, 'diagnostics_dark.png');
      expect(h.tunnel.lifecycle, isEmpty);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(NavigationBar), findsOneWidget);
      h.store.terminationResult = const SessionTerminationResult(
        tunnelStopped: false,
        sessionCleared: true,
        stopError: 'wireguard_stop_timeout',
      );
      await h.controller.signOut();
      await tester.pumpAndSettle();
      expect(
        find.widgetWithText(FilledButton, 'Réessayer l’arrêt'),
        findsOneWidget,
      );
      expect(find.byType(TextFormField), findsNothing);
      await _captureReview(tester, 'session_shutdown_retry.png');
    }, tags: 'golden');

    testWidgets('goldens tablette et connexion arabe agrandie', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1120, 960);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final h = _UiHarness();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.setLocale(const Locale('fr'));
      await tester.pumpWidget(_legacyAuthentication(h.controller));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(2));
      await _captureReview(tester, 'authentication_tablet.png');

      tester.view.physicalSize = const Size(412, 915);
      await h.controller.signIn(
        email: 'client@example.test',
        password: 'mot-de-passe-solide',
      );
      await h.controller.setLocale(const Locale('ar'));
      await h.controller.setThemeMode(ThemeMode.dark);
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
        locationId: 'frankfurt-01',
        locationName: 'Frankfurt 01',
      );
      h.controller.notifyListeners();
      await tester.pumpAndSettle();
      final context = tester.element(find.byType(Scaffold).first);
      expect(Directionality.of(context), TextDirection.rtl);
      final copy = AppLocalizations.of(context);
      expect(
        find.widgetWithText(FilledButton, copy.connection_disconnect),
        findsOneWidget,
      );
      await _captureReview(tester, 'connection_arabic_dark.png');
      tester.view.physicalSize = const Size(320, 640);
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      await tester.pumpAndSettle();
      final disconnect = find.widgetWithText(
        FilledButton,
        copy.connection_disconnect,
      );
      await _reviewScrollTo(tester, disconnect);
      expect(disconnect.hitTestable(), findsOneWidget);
      await _captureReview(tester, 'connection_arabic_200.png');
    }, tags: 'golden');

    testWidgets(
      'parcours complets restent accessibles à 200 % en français et arabe',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        for (final locale in [const Locale('fr'), const Locale('ar')]) {
          for (final size in [const Size(320, 640), const Size(840, 1200)]) {
            tester.view.physicalSize = size;
            final h = _UiHarness();
            try {
              h.store.session = _session;
              h.api.catalogue = _hierarchyCatalogue;
              h.api.enrolledLocation = _frankfurt;
              await h.controller.initialize();
              await h.controller.setLocale(locale);
              await tester.pumpWidget(
                FuzeVpnApp(controller: h.controller, autoInitialize: false),
              );
              await tester.pumpAndSettle();
              final copy = AppLocalizations.of(
                tester.element(find.byType(Scaffold).first),
              );
              final reads = h.api.catalogueReads;
              await _selectReviewDestination(tester, copy.nav_locations);
              final country = find.byKey(const ValueKey('browse-country-DE'));
              await _reviewScrollTo(tester, country);
              expect(country.hitTestable(), findsOneWidget);
              await tester.tap(country);
              await tester.pumpAndSettle();
              final city = find.byKey(
                const ValueKey('browse-city-DE-frankfurt'),
              );
              await _reviewScrollTo(tester, city);
              expect(city.hitTestable(), findsOneWidget);
              await tester.tap(city);
              await tester.pumpAndSettle();
              final favorite = find.byKey(
                const ValueKey('favorite-location-frankfurt-02'),
              );
              await _reviewScrollTo(tester, favorite);
              expect(favorite.hitTestable(), findsOneWidget);
              expect(tester.takeException(), isNull);

              await _selectReviewDestination(tester, copy.nav_account);
              final devices = find.text(copy.devices_manage);
              await _reviewScrollTo(tester, devices);
              expect(devices.hitTestable(), findsOneWidget);
              await tester.tap(devices);
              await tester.pumpAndSettle();
              await _reviewScrollTo(tester, find.text('Test Android'));
              expect(find.text('Test Android').hitTestable(), findsOneWidget);
              final language = find.byKey(const ValueKey('language-settings'));
              await _reviewScrollTo(tester, language);
              expect(language.hitTestable(), findsOneWidget);
              await tester.tap(language);
              await tester.pumpAndSettle();
              expect(find.byType(BottomSheet), findsOneWidget);
              await tester.binding.handlePopRoute();
              await tester.pumpAndSettle();
              final diagnostics = find.byKey(
                const ValueKey('open-diagnostics'),
              );
              await _reviewScrollTo(tester, diagnostics);
              expect(diagnostics.hitTestable(), findsOneWidget);
              await tester.tap(diagnostics);
              await tester.pumpAndSettle();
              final run = find.byKey(const ValueKey('run-diagnostics'));
              await _reviewScrollTo(tester, run);
              expect(run.hitTestable(), findsOneWidget);
              expect(tester.widget<FilledButton>(run).onPressed, isNotNull);
              expect(tester.takeException(), isNull);
              await tester.binding.handlePopRoute();
              await tester.pumpAndSettle();
              await _selectReviewDestination(tester, copy.nav_connection);
              final connect = find.widgetWithText(
                FilledButton,
                copy.connection_connect,
              );
              await _reviewScrollTo(tester, connect);
              expect(connect.hitTestable(), findsOneWidget);
              expect(tester.widget<FilledButton>(connect).onPressed, isNotNull);
              expect(h.api.catalogueReads, reads);
              expect(h.tunnel.lifecycle, isEmpty);
              expect(tester.takeException(), isNull);
            } finally {
              await tester.pumpWidget(const SizedBox.shrink());
              await h.close();
            }
          }
        }
      },
    );

    for (final language in AppLanguages.all) {
      testWidgets('restores ${language.tag} and uses its writing direction', (
        tester,
      ) async {
        final h = _UiHarness();
        addTearDown(h.close);
        h.preferences.locale = language.tag;
        await h.controller.initialize();
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        final context = tester.element(find.byType(Scaffold).first);
        expect(Localizations.localeOf(context), language.locale);
        expect(h.controller.locale, language.locale);
        expect(
          Directionality.of(context),
          {'ar', 'fa', 'ur'}.contains(language.tag)
              ? TextDirection.rtl
              : TextDirection.ltr,
        );
        expect(
          find.text(AppLocalizations.of(context).action_login),
          findsAtLeastNWidgets(1),
        );
        expect(tester.takeException(), isNull);
        // Open the account too: device dates exercise Intl's locale fallback,
        // including script-specific Chinese tags, after Material initializes it.
        h.api.enrolledLocation = _frankfurt;
        await h.controller.signIn(
          email: 'test@example.invalid',
          password: 'password',
        );
        await tester.pumpAndSettle();
        final l = AppLocalizations.of(
          tester.element(find.byType(Scaffold).first),
        );
        await tester.tap(find.text(l.nav_account).last);
        await tester.pumpAndSettle();
        await _scrollTo(tester, find.text(l.devices_manage));
        await tester.tap(find.text(l.devices_manage));
        await tester.pumpAndSettle();
        expect(find.text('Test Android'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await h.controller.setLocale(null);
        expect(h.preferences.locale, isNull);
      });
    }

    testWidgets(
      'language sheet sorts all 30 choices and preserves Chinese script',
      (tester) async {
        tester.view.physicalSize = const Size(320, 640);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final h = _UiHarness();
        addTearDown(h.close);
        await h.controller.initialize();
        await h.controller.signIn(
          email: 'test@example.com',
          password: 'password',
        );
        await h.controller.setLocale(const Locale('fr'));
        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData.fromView(
              tester.view,
            ).copyWith(textScaler: const TextScaler.linear(2)),
            child: FuzeVpnApp(controller: h.controller, autoInitialize: false),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Compte').last);
        await tester.pumpAndSettle();
        await _scrollTo(
          tester,
          find.byKey(const ValueKey('language-settings')),
        );
        await tester.tap(find.byKey(const ValueKey('language-settings')));
        await tester.pumpAndSettle();
        final choices = tester
            .widgetList<ListTile>(find.byType(ListTile))
            .where(
              (tile) =>
                  tile.key is ValueKey<String> &&
                  (tile.key! as ValueKey<String>).value.startsWith(
                    'language-',
                  ) &&
                  tile.key != const ValueKey('language-settings'),
            )
            .toList();
        expect(choices.map((tile) => tile.key), [
          const ValueKey('language-system'),
          ...AppLanguages.sorted.map(
            (item) => ValueKey('language-${item.tag}'),
          ),
        ]);
        final traditional = find.byKey(const ValueKey('language-zh-Hant'));
        await tester.ensureVisible(traditional);
        await tester.pumpAndSettle();
        await tester.tap(traditional);
        await tester.pumpAndSettle();
        expect(h.preferences.locale, 'zh-Hant');
        expect(h.controller.locale?.scriptCode, 'Hant');
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('change immédiatement entre anglais, espagnol et allemand', (
      WidgetTester tester,
    ) async {
      final _UiHarness harness = _UiHarness();
      addTearDown(harness.close);
      await harness.controller.initialize();
      await harness.controller.setLocale(const Locale('en'));

      await tester.pumpWidget(
        FuzeVpnApp(controller: harness.controller, autoInitialize: false),
      );
      expect(find.text('Sign in'), findsAtLeastNWidgets(1));
      expect(harness.preferences.locale, 'en');

      await harness.controller.setLocale(const Locale('es'));
      await tester.pump();
      expect(find.text('Iniciar sesión'), findsAtLeastNWidgets(1));

      await harness.controller.setLocale(const Locale('de'));
      await tester.pump();
      expect(find.text('Anmelden'), findsAtLeastNWidgets(1));
      expect(tester.takeException(), isNull);

      await harness.controller.setLocale(null);
      expect(harness.preferences.locale, isNull);
    });
  });
}

Future<void> _openFrankfurtServers(WidgetTester tester) async {
  final country = find.byKey(const ValueKey('browse-country-DE'));
  await _scrollTo(tester, country);
  await tester.tap(country);
  await tester.pumpAndSettle();
  final city = find.byKey(const ValueKey('browse-city-DE-frankfurt'));
  await _scrollTo(tester, city);
  await tester.tap(city);
  await tester.pumpAndSettle();
}

Widget _legacyAuthentication(VpnAppController controller) => AnimatedBuilder(
  animation: controller,
  builder: (context, _) => MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: controller.locale,
    supportedLocales: AppLanguages.supportedLocales,
    localeListResolutionCallback: AppLanguages.resolve,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    theme: FuzeVpnTheme.light(),
    darkTheme: FuzeVpnTheme.dark(),
    themeMode: controller.themeMode,
    home: controller.isSignedIn
        ? HomeShell(controller: controller)
        : AuthenticationPage(controller: controller),
  ),
);

String _goldenPath(String file) =>
    const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')
    ? '../../build/reports/ui-previews/$file'
    : 'goldens/$file';

Future<void> _reviewScrollTo(WidgetTester tester, Finder target) async {
  // Start from the top so a previous capture cannot hide a lazily built
  // control above the current viewport. Use the foreground route's list.
  FocusManager.instance.primaryFocus?.unfocus();
  final scrollable = find
      .descendant(
        of: find.byType(Scaffold).last,
        matching: find.byType(Scrollable),
      )
      .first;
  tester.state<ScrollableState>(scrollable).position.jumpTo(0);
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(target, 240, scrollable: scrollable);
  await tester.pumpAndSettle();
}

Future<void> _selectReviewDestination(WidgetTester tester, String label) async {
  final navigation = find.byWidgetPredicate(
    (widget) => widget is NavigationBar || widget is NavigationRail,
  );
  final destination = find.descendant(
    of: navigation,
    matching: find.text(label),
  );
  expect(destination.hitTestable(), findsOneWidget);
  await tester.tap(destination);
  await tester.pumpAndSettle();
}

Future<void> _captureReview(
  WidgetTester tester,
  String filename, {
  bool wholeApplication = false,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await _settleImages(tester);
  expect(tester.takeException(), isNull);
  await expectLater(
    wholeApplication
        ? (find.byType(FuzeVpnApp).evaluate().isEmpty
              ? find.byType(MaterialApp)
              : find.byType(FuzeVpnApp))
        : find.byType(Scaffold).last,
    matchesGoldenFile(_goldenPath(filename)),
  );
}

Future<void> _settleImages(WidgetTester tester) async {
  final images = tester.widgetList<Image>(find.byType(Image)).toList();
  final context = tester.element(find.byType(Scaffold).first);
  await tester.runAsync(() async {
    await Future.wait(
      images.map((image) => precacheImage(image.image, context)),
    );
  });
  await tester.pumpAndSettle();
}

Future<void> _scrollTo(
  WidgetTester tester,
  Finder target, {
  double delta = 200,
  bool settle = true,
}) async {
  await tester.scrollUntilVisible(
    target,
    delta,
    scrollable: find.byType(Scrollable).first,
  );
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    // An indeterminate migration indicator intentionally never settles.
    await tester.pump(const Duration(milliseconds: 300));
  }
}

Future<void> _openConnectionDetails(WidgetTester tester) async {
  final details = find.byKey(
    const PageStorageKey<String>('connection-details'),
  );
  await _scrollTo(tester, details);
  final expansible = tester.widget<Expansible>(
    find.descendant(of: details, matching: find.byType(Expansible)),
  );
  if (!expansible.controller.isExpanded) {
    await tester.tap(
      find.descendant(of: details, matching: find.byType(ListTile)).first,
    );
    await tester.pumpAndSettle();
  }
}

class _UiHarness {
  _UiHarness({int migrationMaxPollAttempts = 45})
    : api = _UiApi(),
      store = _MemorySessionStore(),
      preferences = _MemoryPreferences(),
      tunnel = _UiTunnel() {
    controller = VpnAppController(
      api: api,
      sessionStore: store,
      preferences: preferences,
      tunnel: tunnel,
      migrationMaxPollAttempts: migrationMaxPollAttempts,
      migrationDelay: (_) => Future<void>.value(),
    );
  }

  final _UiApi api;
  final _MemorySessionStore store;
  final _MemoryPreferences preferences;
  final _UiTunnel tunnel;
  late final VpnAppController controller;

  Future<void> close() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _UiApi implements VpnApiRepository {
  final List<String> loginEmails = <String>[];
  ApiFailure? locationsFailure;
  ApiFailure? passwordResetFailure;
  Completer<void>? passwordResetRelease;
  DeviceLocationMigration? migrationResult;
  AuthSession loginSession = _session;
  UserProfile profileResult = _profile;
  Location? enrolledLocation;
  List<Location> catalogue = const [_frankfurt, _frankfurt02];
  int catalogueReads = 0;

  @override
  Future<void> confirmPasswordReset({
    required String token,
    required String password,
  }) async {}

  @override
  Future<OpenVpnActivation> createOpenVpnProfile({
    required String token,
    required String deviceId,
    required String csrPem,
    bool requestIpv6 = false,
  }) async => OpenVpnActivation(
    deviceId: deviceId,
    protocol: 'openvpn',
    certificatePem: 'fixture-certificate',
    caCertificatePem: 'fixture-ca',
    tlsCryptV2ClientKey: 'fixture-key',
    endpoint: '198.51.100.10:1194',
    dns: const ['1.1.1.1'],
    address: '10.10.0.2/32',
    serverName: 'fixture.example.test',
    remoteCertTlsServer: true,
    ciphers: const ['AES-256-GCM'],
    notAfter: DateTime.utc(2099),
  );

  @override
  Future<DeviceProfiles> deviceProfiles({
    required String token,
    required String deviceId,
  }) async =>
      const DeviceProfiles(deviceId: 'device-test', profiles: <VpnProfile>[]);

  @override
  Future<List<Location>> locations() async {
    catalogueReads++;
    if (locationsFailure case final ApiFailure failure) throw failure;
    return catalogue;
  }

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    loginEmails.add(email);
    return loginSession;
  }

  @override
  Future<void> logout(String token) async {}

  @override
  Future<DeviceList> listDevices(String token) async => DeviceList(
    limit: 2,
    devices: [
      if (enrolledLocation != null)
        VpnDevice(
          deviceId: 'device-test',
          name: 'Test Android',
          location: enrolledLocation,
          createdAt: DateTime.utc(2026),
        ),
    ],
  );

  @override
  Future<DeviceLocationMigration> startLocationMigration({
    required String token,
    required String deviceId,
    required String locationId,
  }) => throw UnimplementedError('Non utilisé par ce test de widget.');

  @override
  Future<DeviceLocationMigration> getLocationMigration({
    required String token,
    required String deviceId,
    required String migrationId,
  }) async => migrationResult!;

  @override
  Future<UserProfile> me(String token) async => profileResult;

  @override
  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  }) async {
    enrolledLocation = locationId == _frankfurt02.id
        ? _frankfurt02
        : _frankfurt;
    return const DeviceConfiguration(
      deviceId: 'device-test',
      address: '10.10.0.2/32',
      dns: ['1.1.1.1'],
      serverPublicKey: 'fixture-server-key',
      endpoint: '198.51.100.10:51820',
      allowedIps: ['0.0.0.0/0'],
    );
  }

  @override
  Future<RegistrationResult> register(RegisterAccountRequest request) async =>
      RegistrationResult(
        accessToken: _session.accessToken,
        expiresAt: _session.expiresAt,
        verificationEmailSent: true,
      );

  @override
  Future<OpenVpnActivation> renewOpenVpnProfile({
    required String token,
    required String deviceId,
    required String csrPem,
    bool requestIpv6 = false,
  }) => throw UnimplementedError('Non utilisé par ce test de widget.');

  @override
  Future<void> requestPasswordReset(String email) async {
    if (passwordResetRelease case final Completer<void> release) {
      await release.future;
    }
    if (passwordResetFailure case final ApiFailure failure) throw failure;
  }

  @override
  Future<void> resendVerification(String token) async {}

  @override
  Future<void> revokeDevice({
    required String token,
    required String deviceId,
  }) async {}

  @override
  Future<void> revokeOpenVpnProfile({
    required String token,
    required String deviceId,
  }) async {}

  @override
  Future<UserProfile> updateMe({
    required String token,
    required UpdateProfileRequest request,
  }) async => _profile;

  @override
  Future<bool> verifyEmail(String token) async => true;
}

class _MemorySessionStore implements SecureSessionStore, GuestOnboardingStore {
  AuthSession? session;
  final admittedGuests = <String>{};
  @override
  Future<bool> readGuestOnboardingCompleted({required String userId}) async =>
      admittedGuests.contains(userId);
  @override
  Future<void> writeGuestOnboardingCompleted({required String userId}) async {
    admittedGuests.add(userId);
  }

  SessionTerminationResult terminationResult =
      const SessionTerminationResult.complete();
  Completer<void>? clearRelease;
  int clearCalls = 0;
  final Map<String, String> _deviceIds = <String, String>{};
  final Map<String, DeviceLocationMigration> migrations = {};

  @override
  Future<void> clearCurrentDeviceId({required String userId}) async {
    _deviceIds.remove(userId);
  }

  @override
  Future<void> clearLocationMigration({
    required String userId,
    required String deviceId,
  }) async {
    migrations.remove('$userId/$deviceId');
  }

  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    clearCalls++;
    if (clearRelease != null) await clearRelease!.future;
    session = null;
    return terminationResult;
  }

  @override
  Future<String?> readCurrentDeviceId({required String userId}) async =>
      _deviceIds[userId];

  @override
  Future<DeviceLocationMigration?> readLocationMigration({
    required String userId,
    required String deviceId,
  }) async => migrations['$userId/$deviceId'];

  @override
  Future<AuthSession?> readSession() async => session;

  @override
  Future<void> writeCurrentDeviceId({
    required String userId,
    required String deviceId,
  }) async {
    _deviceIds[userId] = deviceId;
  }

  @override
  Future<void> writeLocationMigration({
    required String userId,
    required DeviceLocationMigration migration,
  }) async {
    migrations['$userId/${migration.deviceId}'] = migration;
  }

  @override
  Future<void> writeSession(AuthSession value, {String? userId}) async {
    session = value;
  }
}

class _MemoryPreferences implements AppPreferenceStore {
  String? themeMode;
  String? locale;
  String? selectedProtocol;
  String? selectedLocation;
  final Map<String, bool> verificationNeeded = <String, bool>{};

  @override
  Future<String?> readLocale() async => locale;

  @override
  Future<String?> readSelectedLocation() async => selectedLocation;

  @override
  Future<String?> readSelectedProtocol() async => selectedProtocol;

  @override
  Future<String?> readThemeMode() async => themeMode;

  @override
  Future<bool?> readVerificationNeeded({required String userId}) async =>
      verificationNeeded[userId];

  @override
  Future<void> writeLocale(String? languageCode) async {
    locale = languageCode;
  }

  @override
  Future<void> writeSelectedLocation(String value) async {
    selectedLocation = value;
  }

  @override
  Future<void> writeSelectedProtocol(String value) async {
    selectedProtocol = value;
  }

  @override
  Future<void> writeThemeMode(String value) async {
    themeMode = value;
  }

  @override
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  }) async {
    verificationNeeded[userId] = value;
  }
}

class _UiTunnel implements VpnTunnelGateway {
  final List<String> lifecycle = [];
  bool completeConnections = false;
  OpenVpnRevocationResult? pendingRevocation;
  int cleanupCalls = 0;
  @override
  Future<OpenVpnRevocationResult?> getOpenVpnRevocation({
    required String accountId,
    required String deviceId,
  }) async => pendingRevocation;
  @override
  Future<OpenVpnRevocationResult> cleanRevokedOpenVpnIdentity({
    required String accountId,
    required String deviceId,
    required String csrSha256,
  }) async {
    cleanupCalls++;
    pendingRevocation = null;
    return OpenVpnRevocationResult(
      accountId: accountId,
      deviceId: deviceId,
      csrSha256: csrSha256,
      tunnelStopped: true,
      identityCleared: true,
      tileCleared: true,
      markerCleared: true,
    );
  }

  final StreamController<VpnRuntimeState> _states =
      StreamController<VpnRuntimeState>.broadcast();
  int disconnectCalls = 0;
  Completer<VpnRuntimeState>? pendingState;
  VpnRuntimeState initialState = const VpnRuntimeState(
    phase: VpnRuntimePhase.idle,
  );

  @override
  Stream<VpnRuntimeState> get states => _states.stream;

  @override
  Future<void> clearAccountIdentity({
    required String accountId,
    required String? expectedDeviceId,
  }) async {}

  @override
  Future<void> clearOpenVpnIdentity({
    required String accountId,
    required String deviceId,
  }) async {}

  Future<void> close() => _states.close();

  @override
  Future<void> connectOpenVpn({
    required String accountId,
    required OpenVpnActivation activation,
    required Location location,
    bool preserveExistingCertificate = false,
    bool renewal = false,
  }) async => _connected(VpnProtocol.openVpn, location);

  @override
  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  }) async => _connected(VpnProtocol.wireGuard, location);

  void _connected(VpnProtocol protocol, Location location) {
    lifecycle.add('connect:${protocol.apiValue}:${location.id}');
    if (!completeConnections) return;
    initialState = VpnRuntimeState(
      phase: VpnRuntimePhase.connected,
      protocol: protocol,
      locationId: location.id,
      locationName: location.displayName,
    );
    _states.add(initialState);
  }

  @override
  Future<void> disconnect() async {
    disconnectCalls += 1;
    lifecycle.add('disconnect');
    if (completeConnections) {
      initialState = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
      _states.add(initialState);
    }
  }

  @override
  Future<String> getOrCreateOpenVpnCsr({
    required String accountId,
    required String deviceId,
    bool renewal = false,
  }) async => 'public-csr';

  @override
  Future<OpenVpnCertificateStatus> getOpenVpnCertificateStatus({
    required String accountId,
    required String deviceId,
  }) async => const OpenVpnCertificateStatus(
    phase: OpenVpnCertificatePhase.missing,
    renewalPending: false,
  );

  @override
  Future<String> getOrCreateWireGuardPublicKey({
    required String accountId,
  }) async => 'public-key';

  @override
  Future<VpnRuntimeState> getState() async =>
      pendingState == null ? initialState : await pendingState!.future;

  @override
  Future<bool> requestVpnPermission() async => true;
}

final AuthSession _session = AuthSession(
  accessToken: 'session-test',
  expiresAt: DateTime.utc(2099, 1, 1),
);
