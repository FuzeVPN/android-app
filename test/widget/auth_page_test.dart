import 'dart:ui' show CheckedState, SemanticsAction;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/password_policy.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

void main() {
  final passwordCases = <(String, String, PasswordLengthIssue?)>[
    ('ASCII 7 bytes', 'a' * 7, PasswordLengthIssue.tooShort),
    ('ASCII 8 bytes', 'a' * 8, null),
    ('ASCII 72 bytes', 'a' * 72, null),
    ('ASCII 73 bytes', 'a' * 73, PasswordLengthIssue.tooLong),
    ('accented 8 bytes', 'é' * 4, null),
    ('accented 74 bytes', 'é' * 37, PasswordLengthIssue.tooLong),
    ('combining 72 bytes', 'e\u0301' * 24, null),
    ('emoji 76 bytes', '🚀' * 19, PasswordLengthIssue.tooLong),
  ];
  for (final (description, password, issue) in passwordCases) {
    testWidgets('registration checks $description before any API call', (
      tester,
    ) async {
      final api = _RecordingRegistrationApi();
      final controller = _controller(api: api);
      addTearDown(controller.dispose);
      await tester.pumpWidget(_testApp(controller));
      await tester.tap(find.text('Inscription'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextFormField).at(0),
        'fixture@example.invalid',
      );
      await tester.enterText(find.byType(TextFormField).at(1), password);
      await tester.ensureVisible(find.text('Continuer'));
      await tester.pumpAndSettle();
      expect(find.text('Continuer').hitTestable(), findsOneWidget);
      await tester.tap(find.text('Continuer'));
      await tester.pumpAndSettle();
      expect(
        find.text('Identité'),
        issue == null ? findsOneWidget : findsNothing,
      );
      if (issue != null) {
        final localizations = AppLocalizations.of(
          tester.element(find.byType(TextFormField).first),
        );
        final message = issue == PasswordLengthIssue.tooShort
            ? localizations.validation_password
            : localizations.validation_passwordTooLong;
        expect(find.text(message), findsOneWidget);
      }
      expect(api.registrations, isEmpty);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('registration sends the exact original Unicode password', (
    tester,
  ) async {
    final api = _RecordingRegistrationApi();
    final controller = _controller(api: api);
    addTearDown(controller.dispose);
    const password = ' é e\u0301 🚀 ';
    await tester.pumpWidget(_testApp(controller));
    await tester.tap(find.text('Inscription'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'fixture@example.invalid',
    );
    await tester.enterText(find.byType(TextFormField).at(1), password);
    await tester.ensureVisible(find.text('Continuer'));
    await tester.pumpAndSettle();
    expect(find.text('Continuer').hitTestable(), findsOneWidget);
    await tester.ensureVisible(find.text('Continuer'));
    await tester.pumpAndSettle();
    expect(find.text('Continuer').hitTestable(), findsOneWidget);
    await tester.tap(find.text('Continuer'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Épreuve');
    await tester.enterText(find.byType(TextFormField).at(1), '测试');
    await tester.enterText(find.byType(TextFormField).at(2), '+33100000000');
    await tester.ensureVisible(find.text('Continuer'));
    await tester.pumpAndSettle();
    expect(find.text('Continuer').hitTestable(), findsOneWidget);
    await tester.ensureVisible(find.text('Continuer'));
    await tester.pumpAndSettle();
    expect(find.text('Continuer').hitTestable(), findsOneWidget);
    await tester.tap(find.text('Continuer'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Voie de test');
    await tester.enterText(find.byType(TextFormField).at(2), '00000');
    await tester.enterText(find.byType(TextFormField).at(3), 'Ville de test');
    for (final id in ['terms', 'privacy']) {
      final checkbox = find.byKey(ValueKey('registration-$id-consent'));
      await tester.ensureVisible(checkbox);
      await tester.pumpAndSettle();
      await tester.tap(checkbox);
      await tester.pump();
    }
    await tester.ensureVisible(find.text('Créer mon compte'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Créer mon compte'));
    await tester.pumpAndSettle();
    expect(api.registrations.single.password, password);
    expect(api.registrations.single.firstName, 'Épreuve');
    expect(api.registrations.single.lastName, '测试');
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'screen reader opens independent consent links without accepting them at 200 percent',
    (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final semantics = tester.ensureSemantics();
      try {
        const launcher = MethodChannel('plugins.flutter.io/url_launcher');
        final opened = <String>[];
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
        final api = _RecordingRegistrationApi();
        final controller = _controller(api: api);
        addTearDown(controller.dispose);
        await tester.pumpWidget(_testApp(controller));
        await tester.scrollUntilVisible(
          find.text('Inscription'),
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Inscription'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byType(TextFormField).at(0),
          'fixture@example.invalid',
        );
        await tester.enterText(
          find.byType(TextFormField).at(1),
          'fixture-password',
        );
        await tester.ensureVisible(find.text('Continuer'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Continuer'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextFormField).at(0), 'Camille');
        await tester.enterText(find.byType(TextFormField).at(1), 'Martin');
        await tester.enterText(
          find.byType(TextFormField).at(2),
          '+33612345678',
        );
        await tester.ensureVisible(find.text('Continuer'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Continuer'));
        await tester.pumpAndSettle();

        for (final (id, label, expectedUrl) in [
          (
            'terms',
            'conditions d’utilisation',
            'https://fuzevpn.com/fr/terms.html',
          ),
          (
            'privacy',
            'politique de confidentialité',
            'https://fuzevpn.com/fr/privacy.html',
          ),
        ]) {
          final checkbox = find.byKey(ValueKey('registration-$id-consent'));
          await tester.ensureVisible(checkbox);
          await tester.pumpAndSettle();
          final checkboxNode = tester.getSemantics(checkbox);
          expect(
            checkboxNode.getSemanticsData().flagsCollection.isChecked,
            CheckedState.isFalse,
          );
          expect(
            checkboxNode.getSemanticsData().hasAction(SemanticsAction.tap),
            isTrue,
          );
          final link = find.byKey(ValueKey('registration-$id-link'));
          await tester.ensureVisible(link);
          await tester.pumpAndSettle();
          final linkNode = tester.getSemantics(link);
          final linkData = linkNode.getSemanticsData();
          expect(linkData.flagsCollection.isLink, isTrue);
          expect(linkData.label, label);
          expect(linkData.hasAction(SemanticsAction.tap), isTrue);
          expect(linkNode.id, isNot(checkboxNode.id));
          expect(linkData.flagsCollection.isChecked, CheckedState.none);
          // Use the accessibility action itself, as TalkBack does, rather than
          // tapping the visual text and accidentally testing only pointer input.
          tester
              .renderObject<RenderObject>(link)
              .owner!
              .semanticsOwner!
              .performAction(linkNode.id, SemanticsAction.tap);
          await tester.pumpAndSettle();
          expect(opened.last, expectedUrl);
          for (final consent in ['terms', 'privacy']) {
            expect(
              tester
                  .widget<Checkbox>(
                    find.byKey(ValueKey('registration-$consent-consent')),
                  )
                  .value,
              isFalse,
            );
          }
        }
        final terms = find.byKey(const ValueKey('registration-terms-consent'));
        await tester.ensureVisible(terms);
        await tester.pumpAndSettle();
        final checkboxNode = tester.getSemantics(terms);
        tester
            .renderObject<RenderObject>(terms)
            .owner!
            .semanticsOwner!
            .performAction(checkboxNode.id, SemanticsAction.tap);
        await tester.pumpAndSettle();
        expect(tester.widget<Checkbox>(terms).value, isTrue);
        expect(
          tester
              .widget<Checkbox>(
                find.byKey(const ValueKey('registration-privacy-consent')),
              )
              .value,
          isFalse,
        );
        expect(api.registrations, isEmpty);
        expect(tester.takeException(), isNull);
      } finally {
        semantics.dispose();
      }
    },
  );

  testWidgets('login keeps its existing nonempty password validation', (
    tester,
  ) async {
    final controller = _controller();
    addTearDown(controller.dispose);
    await tester.pumpWidget(_testApp(controller));
    final password = tester.widget<TextFormField>(
      find.byType(TextFormField).at(1),
    );
    expect(password.validator!(''), isNotNull);
    expect(password.validator!('é'), isNull);
    expect(password.validator!('a' * 73), isNull);
  });

  testWidgets(
    'registration byte guidance wraps at 200 percent text on a compact screen',
    (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final controller = _controller();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData.fromView(
            tester.view,
          ).copyWith(textScaler: const TextScaler.linear(2)),
          child: _testApp(controller),
        ),
      );
      await tester.scrollUntilVisible(
        find.text('Inscription'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Inscription'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byType(TextFormField).at(1));
      final fieldContext = tester.element(find.byType(TextFormField).at(1));
      final localizations = AppLocalizations.of(fieldContext);
      expect(MediaQuery.textScalerOf(fieldContext).scale(1), 2);
      final guidance = tester.renderObject<RenderParagraph>(
        find.text(localizations.form_passwordMin),
      );
      expect(guidance.didExceedMaxLines, isFalse);
      await tester.enterText(find.byType(TextFormField).at(1), 'é' * 37);
      await tester.ensureVisible(find.text('Continuer'));
      await tester.pumpAndSettle();
      expect(find.text('Continuer').hitTestable(), findsOneWidget);
      await tester.tap(find.text('Continuer'));
      await tester.pumpAndSettle();
      expect(
        find.text(localizations.validation_passwordTooLong),
        findsOneWidget,
      );
      final error = tester.renderObject<RenderParagraph>(
        find.text(localizations.validation_passwordTooLong),
      );
      expect(error.didExceedMaxLines, isFalse);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('registration preserves data while moving across three steps', (
    WidgetTester tester,
  ) async {
    final VpnAppController controller = _controller();
    addTearDown(controller.dispose);

    await tester.pumpWidget(_testApp(controller));
    await tester.tap(find.text('Inscription'));
    await tester.pumpAndSettle();

    expect(find.text('Compte'), findsOneWidget);
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'client@example.test',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'mot-de-passe-solide',
    );
    await tester.ensureVisible(find.text('Continuer'));
    await tester.pumpAndSettle();
    expect(find.text('Continuer').hitTestable(), findsOneWidget);
    await tester.tap(find.text('Continuer'));
    await tester.pumpAndSettle();

    expect(find.text('Identité'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), 'Camille');
    await tester.enterText(find.byType(TextFormField).at(1), 'Martin');
    await tester.enterText(find.byType(TextFormField).at(2), '+33612345678');
    await tester.ensureVisible(find.text('Continuer'));
    await tester.pumpAndSettle();
    expect(find.text('Continuer').hitTestable(), findsOneWidget);
    await tester.tap(find.text('Continuer'));
    await tester.pumpAndSettle();

    expect(find.text('Adresse et accords'), findsOneWidget);
    await tester.drag(find.byType(ListView).first, const Offset(0, -700));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Retour'));
    await tester.pumpAndSettle();
    expect(find.text('Retour').hitTestable(), findsOneWidget);
    await tester.tap(find.text('Retour'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextFormField>(find.byType(TextFormField).at(0))
          .controller
          ?.text,
      'Camille',
    );

    await tester.drag(find.byType(ListView).first, const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Retour'));
    await tester.pumpAndSettle();
    expect(find.text('Retour').hitTestable(), findsOneWidget);
    await tester.tap(find.text('Retour'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextFormField>(find.byType(TextFormField).at(0))
          .controller
          ?.text,
      'client@example.test',
    );
    expect(tester.takeException(), isNull);
  });

  for (final language in AppLanguages.all) {
    testWidgets(
      'compact authentication ${language.tag} stays scrollable at 200 percent text',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(320, 640);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final VpnAppController controller = _controller();
        addTearDown(controller.dispose);

        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData.fromView(
              tester.view,
            ).copyWith(textScaler: const TextScaler.linear(2)),
            child: _testApp(controller, locale: language.locale),
          ),
        );

        final localizations = AppLocalizations.of(
          tester.element(find.byType(AuthenticationPage)),
        );
        expect(localizations.localeName.replaceAll('_', '-'), language.tag);
        expect(find.text('FuzeVPN'), findsOneWidget);
        final signIn = find.widgetWithText(
          FilledButton,
          localizations.action_login,
        );
        await tester.scrollUntilVisible(
          signIn,
          240,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        expect(signIn.hitTestable(), findsOneWidget);
        expect(find.byType(ListView), findsWidgets);
        expect(tester.takeException(), isNull);
      },
    );
  }
}

Widget _testApp(
  VpnAppController controller, {
  Locale locale = const Locale('fr'),
}) => MaterialApp(
  locale: locale,
  supportedLocales: AppLanguages.supportedLocales,
  localeListResolutionCallback: AppLanguages.resolve,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  theme: FuzeVpnTheme.light(),
  home: AuthenticationPage(controller: controller),
);

VpnAppController _controller({VpnApiRepository? api}) => VpnAppController(
  api: api ?? _UnusedApi(),
  sessionStore: _UnusedStore(),
  preferences: _UnusedPreferences(),
  tunnel: _IdleTunnel(),
);

class _UnusedApi implements VpnApiRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RecordingRegistrationApi extends _UnusedApi {
  final List<RegisterAccountRequest> registrations = <RegisterAccountRequest>[];

  @override
  Future<RegistrationResult> register(RegisterAccountRequest request) async {
    registrations.add(request);
    // Stop before session storage. This is a fake repository, with no network.
    throw const ApiException(statusCode: 500, errorCode: 'server_error');
  }
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
