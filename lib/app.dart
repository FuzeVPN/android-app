import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_controller.dart';
import 'app_theme.dart';
import 'core/api_client.dart';
import 'core/diagnostics.dart';
import 'core/google_credentials.dart';
import 'features/auth/welcome_page.dart';
import 'features/home/home_shell.dart';
import 'l10n/app_copy.dart';
import 'l10n/app_languages.dart';
import 'l10n/generated/app_localizations.dart';
import 'native_vpn_bridge.dart';
import 'play_billing_bridge.dart';
import 'widgets/fuze_brand.dart';
import 'widgets/fuze_design.dart';
import 'widgets/language_settings.dart';
import 'widgets/notice_card.dart';
import 'widgets/vpn_disclosure_dialog.dart';

class FuzeVpnApp extends StatefulWidget {
  const FuzeVpnApp({super.key, this.controller, this.autoInitialize = true});

  final VpnAppController? controller;
  final bool autoInitialize;

  @override
  State<FuzeVpnApp> createState() => _FuzeVpnAppState();
}

class _FuzeVpnAppState extends State<FuzeVpnApp> with WidgetsBindingObserver {
  static const String _debugApiBaseUrl = String.fromEnvironment(
    'FUZEVPN_API_BASE_URL',
  );

  late final VpnAppController _controller;
  late final bool _ownsController;
  ApiHttpTransport? _diagnosticTransport;
  var _navigatorKey = GlobalKey<NavigatorState>();
  String? _navigatorScope;

  GlobalKey<NavigatorState> _currentNavigatorKey() {
    final scope = _controller.sessionTermination != null
        ? 'session-cleanup'
        : _controller.openVpnRevocation != null
        ? 'openvpn-cleanup'
        : 'app';
    if (_navigatorScope != scope) {
      _navigatorScope = scope;
      _navigatorKey = GlobalKey<NavigatorState>();
    }
    return _navigatorKey;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _registerBundledLicenses();
    _ownsController = widget.controller == null;
    if (_ownsController) {
      final NativeVpnBridge bridge = NativeVpnBridge(
        confirmVpnUse: () async {
          final context = _navigatorKey.currentContext;
          if (!mounted || context == null) return false;
          final accepted = await showVpnDisclosureDialog(context);
          return mounted && context.mounted && accepted;
        },
      );
      final NativeSecureStore store = NativeSecureStore(bridge);
      final ApiClient api = ApiClient(baseUri: _debugBaseUri());
      final google = NativeGoogleCredentialGateway();
      _diagnosticTransport = IoApiHttpTransport();
      _controller = VpnAppController(
        api: api,
        sessionStore: store,
        preferences: store,
        tunnel: bridge,
        billingGateway: NativePlayBillingGateway(),
        googleGateway: google,
        googlePendingStore: google,
        diagnostics: DiagnosticService(
          transport: _diagnosticTransport!,
          baseUri: api.baseUri,
        ),
      );
    } else {
      _controller = widget.controller!;
    }
    if (widget.autoInitialize) unawaited(_controller.initialize());
  }

  /// An endpoint override is accepted only in debug builds. Release and
  /// profile builds always use the production control plane.
  Uri? _debugBaseUri() {
    if (!kDebugMode || _debugApiBaseUrl.isEmpty) {
      return null;
    }
    return Uri.tryParse(_debugApiBaseUrl);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_ownsController) _controller.dispose();
    _diagnosticTransport?.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_controller.onAppResumed());
    } else {
      _controller.onAppPaused();
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (BuildContext context, Widget? child) => MaterialApp(
      navigatorKey: _currentNavigatorKey(),
      // Dismiss account dialogs too when the mandatory cleanup screen takes over.
      key: ValueKey<String>(
        _controller.sessionTermination != null
            ? 'session-cleanup'
            : _controller.openVpnRevocation != null
            ? 'openvpn-cleanup'
            : 'app',
      ),
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      locale: _controller.locale,
      supportedLocales: AppLanguages.supportedLocales,
      localeListResolutionCallback: AppLanguages.resolve,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: FuzeVpnTheme.light(),
      darkTheme: FuzeVpnTheme.dark(),
      themeMode: _controller.themeMode,
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: FuzeVpnTheme.systemUiOverlayStyle(Theme.of(context).brightness),
        child: child!,
      ),
      home: _controller.sessionTermination != null
          ? _SessionTerminationPage(controller: _controller)
          : _controller.openVpnRevocation != null
          ? _OpenVpnRevocationPage(controller: _controller)
          : _controller.isInitializing
          ? const _StartupPage()
          : _controller.hasPendingAccountRestoration
          ? _AccountRestorationPage(controller: _controller)
          : _controller.canShowHome
          ? HomeShell(controller: _controller)
          : WelcomePage(controller: _controller),
    ),
  );
}

class _AccountRestorationPage extends StatelessWidget {
  const _AccountRestorationPage({required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final VpnRuntimePhase phase = controller.tunnelState.phase;
    final bool compactDisconnect =
        MediaQuery.sizeOf(context).width < 360 &&
        MediaQuery.textScalerOf(context).scale(16) > 24;
    final String statusKey = switch (phase) {
      VpnRuntimePhase.connected => 'status.connected',
      VpnRuntimePhase.idle => 'status.idle',
      VpnRuntimePhase.disconnecting => 'status.disconnecting',
      VpnRuntimePhase.error => 'status.error',
      _ => 'status.connecting',
    };
    return _ApplicationStateFrame(
      key: const ValueKey('account-restoration-page'),
      title: context.copy('accountRestoration.title'),
      message: context.copy('accountRestoration.message'),
      icon: Icons.manage_accounts_outlined,
      headerAction: LanguageSettings(
        key: const ValueKey('restoration-language-settings'),
        locale: controller.locale,
        onChanged: controller.setLocale,
        compact: true,
      ),
      children: [
        FuzePanel(
          tone: FuzePanelTone.wash,
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.shield_outlined,
                size: 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  context.copy(statusKey),
                  key: const ValueKey('restoration-vpn-status'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          key: const ValueKey('retry-account-restoration'),
          onPressed: controller.isRestoringAccount
              ? null
              : controller.retryAccountRestoration,
          icon: controller.isRestoringAccount
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.refresh),
          label: Text(context.copy('action.retry')),
        ),
        if (phase != VpnRuntimePhase.idle) ...[
          const SizedBox(height: 12),
          OutlinedButton.icon(
            key: const ValueKey('restoration-disconnect-vpn'),
            style: compactDisconnect
                ? OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 14,
                    ),
                  )
                : null,
            onPressed: phase == VpnRuntimePhase.disconnecting
                ? null
                : controller.requestUserDisconnect,
            icon: compactDisconnect ? null : const Icon(Icons.link_off),
            label: Text(
              context.copy('connection.disconnect'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        if (controller.supportsSystemProtectionSettings) ...[
          const SizedBox(height: 8),
          TextButton(
            onPressed: controller.openSystemVpnSettings,
            child: Text(context.copy('protection.openSettings')),
          ),
        ],
        const SizedBox(height: 8),
        TextButton(
          key: const ValueKey('restoration-sign-out'),
          onPressed: controller.signOut,
          child: Text(context.copy('settings.signOut')),
        ),
        if (controller.notice != null) ...[
          const SizedBox(height: 16),
          NoticeCard(
            notice: controller.notice,
            onDismiss: controller.clearNotice,
          ),
        ],
      ],
    );
  }
}

class _OpenVpnRevocationPage extends StatelessWidget {
  const _OpenVpnRevocationPage({required this.controller});
  final VpnAppController controller;
  @override
  Widget build(BuildContext context) {
    final result = controller.openVpnRevocation!;
    return _ApplicationStateFrame(
      title: context.copy('openvpnCleanup.title'),
      message: context.copy(
        result.inProgress
            ? 'openvpnCleanup.working'
            : result.tunnelStopped
            ? 'openvpnCleanup.cleanupFailed'
            : 'openvpnCleanup.stopFailed',
      ),
      icon: Icons.security_outlined,
      children: [
        if (result.inProgress)
          const _StatePageProgress()
        else
          FilledButton.icon(
            onPressed: controller.retryOpenVpnRevocation,
            icon: const Icon(Icons.refresh),
            label: Text(
              context.copy(
                result.tunnelStopped
                    ? 'session.retryCleanup'
                    : 'session.retryStop',
              ),
            ),
          ),
        if (result.stopError != null || result.storageError != null) ...[
          const SizedBox(height: 16),
          _StatePageErrorDetails(
            text: [
              result.stopError,
              result.storageError,
            ].whereType<String>().join(' · '),
          ),
        ],
      ],
    );
  }
}

class _SessionTerminationPage extends StatelessWidget {
  const _SessionTerminationPage({required this.controller});
  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final result = controller.sessionTermination!;
    final bool stopPending = !result.tunnelStopped;
    return _ApplicationStateFrame(
      title: context.copy('session.endingTitle'),
      message: context.copy(
        result.inProgress
            ? 'session.ending'
            : stopPending
            ? 'session.stopFailed'
            : 'session.cleanupFailed',
      ),
      icon: Icons.logout,
      children: <Widget>[
        FuzePanel(
          tone: FuzePanelTone.wash,
          padding: const EdgeInsets.all(14),
          child: Text(
            context.copy('session.systemProtectionNote'),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: 20),
        if (result.inProgress)
          const _StatePageProgress()
        else
          FilledButton.icon(
            onPressed: controller.retrySessionTermination,
            icon: const Icon(Icons.refresh),
            label: Text(
              context.copy(
                stopPending ? 'session.retryStop' : 'session.retryCleanup',
              ),
            ),
          ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: controller.openSystemVpnSettings,
          child: Text(context.copy('protection.openSettings')),
        ),
        if (result.stopError != null || result.storageError != null) ...[
          const SizedBox(height: 16),
          _StatePageErrorDetails(
            text: [
              result.stopError,
              result.storageError,
            ].whereType<String>().join(' · '),
          ),
        ],
      ],
    );
  }
}

class _StartupPage extends StatelessWidget {
  const _StartupPage();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: FuzePanel(
              tone: FuzePanelTone.dark,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Center(
                    child: FuzeBrand(emblemSize: 44, color: FuzeVpnTheme.paper),
                  ),
                  const SizedBox(height: 36),
                  const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: FuzeVpnTheme.signal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    context.copy('startup'),
                    textAlign: TextAlign.center,
                    style: FuzeVpnTheme.mono(
                      fontSize: 12,
                      color: FuzeVpnTheme.paper,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _ApplicationStateFrame extends StatelessWidget {
  const _ApplicationStateFrame({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.children,
    this.headerAction,
  });

  final String title;
  final String message;
  final IconData icon;
  final List<Widget> children;
  final Widget? headerAction;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight > 48
                  ? constraints.maxHeight - 48
                  : 0,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        const FuzeBrand(emblemSize: 32),
                        if (headerAction != null) headerAction!,
                      ],
                    ),
                    const SizedBox(height: 24),
                    FuzePanel(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: ExcludeSemantics(
                              child: Container(
                                width: 48,
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: FuzeVpnTheme.signal,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(icon, color: FuzeVpnTheme.ink),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FuzePageHeader(
                            title: title,
                            description: message,
                            compact: true,
                          ),
                          ...children,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _StatePageProgress extends StatelessWidget {
  const _StatePageProgress();

  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: EdgeInsets.all(12),
      child: SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    ),
  );
}

class _StatePageErrorDetails extends StatelessWidget {
  const _StatePageErrorDetails({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => FuzePanel(
    tone: FuzePanelTone.wash,
    padding: const EdgeInsets.all(14),
    child: Text(
      text,
      style: FuzeVpnTheme.mono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    ),
  );
}

bool _bundledLicensesRegistered = false;

void _registerBundledLicenses() {
  if (_bundledLicensesRegistered) return;
  _bundledLicensesRegistered = true;
  LicenseRegistry.addLicense(() async* {
    final String archivo = await rootBundle.loadString(
      'assets/fonts/Archivo-OFL.txt',
    );
    final String plex = await rootBundle.loadString(
      'assets/fonts/IBMPlexMono-OFL.txt',
    );
    yield LicenseEntryWithLineBreaks(
      const <String>['Google Sans'],
      '${await rootBundle.loadString('assets/fonts/GoogleSans-OFL.txt')}\n\n'
      '${await rootBundle.loadString('assets/fonts/GoogleSans-TRADEMARKS.md')}',
    );
    yield LicenseEntryWithLineBreaks(<String>['Archivo'], archivo);
    yield LicenseEntryWithLineBreaks(<String>['IBM Plex Mono'], plex);
    yield LicenseEntryWithLineBreaks(<String>[
      'Noto Sans Arabic',
    ], await rootBundle.loadString('assets/fonts/NotoSansArabic-OFL.txt'));
    yield LicenseEntryWithLineBreaks(
      <String>['Twemoji — Twitter, Inc. and contributors'],
      'Country flag artwork from Twemoji v14.0.2, unmodified. '
      'https://github.com/twitter/twemoji\n\n'
      '${await rootBundle.loadString('assets/licenses/TWEMOJI.txt')}',
    );
    yield LicenseEntryWithLineBreaks(
      <String>['Unicode CLDR'],
      'Country names from Unicode CLDR 47.0.0. '
      'https://github.com/unicode-org/cldr-json\n\n'
      '${await rootBundle.loadString('assets/licenses/UNICODE.txt')}',
    );
    for (final component in <String, String>{
      'OpenVPN 3 Core': 'OPENVPN3',
      'OpenSSL': 'OPENSSL',
      'WireGuard Android tunnel library': 'WIREGUARD',
      'wireguard-go': 'WIREGUARD-GO',
      'wireguard-tools': 'WIREGUARD-TOOLS',
      'Asio': 'ASIO',
      'fmt': 'FMT',
      'LZ4': 'LZ4',
      'Go runtime': 'GO',
      'golang.org/x/crypto': 'GO-CRYPTO',
      'golang.org/x/net': 'GO-NET',
      'golang.org/x/sys': 'GO-SYS',
    }.entries) {
      yield LicenseEntryWithLineBreaks(<String>[
        component.key,
      ], await rootBundle.loadString('assets/licenses/${component.value}.txt'));
    }
  });
}
