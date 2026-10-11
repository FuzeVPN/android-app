import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_controller.dart';
import '../../app_theme.dart';
import '../../core/models.dart';
import '../../core/password_policy.dart';
import '../../core/public_links.dart';
import '../../google_auth_controller.dart';
import '../../l10n/app_copy.dart';
import '../../widgets/external_link.dart';
import '../../widgets/fuze_brand.dart';
import '../../widgets/fuze_design.dart';
import '../../widgets/google_sign_in_button.dart';
import '../../widgets/language_settings.dart';
import '../../widgets/notice_card.dart';
import '../home/home_shell.dart' show DiagnosticsPage;
import 'google_auth_page.dart';

/// Separate account login. Dismissing an idle dialog never ends the guest session.
class AuthenticationDialog extends StatefulWidget {
  const AuthenticationDialog({super.key, required this.controller});

  final VpnAppController controller;

  @override
  State<AuthenticationDialog> createState() => _AuthenticationDialogState();
}

class _AuthenticationDialogState extends State<AuthenticationDialog> {
  bool _dismissScheduled = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (!mounted) return;
    setState(() {});
    final profile = widget.controller.profile;
    if (_dismissScheduled ||
        widget.controller.isAuthenticating ||
        !widget.controller.isSignedIn ||
        profile?.isGuest != false ||
        profile?.profileRedacted != false ||
        profile?.canManageAccount != true) {
      return;
    }
    _dismissScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _dismissScheduled = false;
      // Account cleanup may already have replaced the app's navigator.
      if (ModalRoute.of(context)?.isCurrent == true) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final busy = widget.controller.isAuthenticating;
    return PopScope(
      // A submitted login must not replace the account after a silent dismissal.
      canPop: !busy,
      child: Dialog(
        key: const ValueKey('guest-login-dialog'),
        clipBehavior: Clip.antiAlias,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: SizedBox(
            height: (MediaQuery.sizeOf(context).height * .85).clamp(
              240.0,
              640.0,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // A fixed multiline title can leave less room than a submit
                // button with large text once the keyboard reduces the dialog.
                final scrollTitle =
                    constraints.maxHeight < 440 ||
                    MediaQuery.textScalerOf(context).scale(1) > 1.3;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        24,
                        16,
                        12,
                        8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Visibility(
                              visible: !scrollTitle,
                              child: Text(
                                context.copy('action.login'),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                          IconButton(
                            key: const ValueKey('guest-login-close'),
                            tooltip: MaterialLocalizations.of(
                              context,
                            ).closeButtonTooltip,
                            onPressed: busy
                                ? null
                                : () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ListView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                        children: [
                          // Keep this item in place when IME/scale changes so the
                          // form retains its state and the close action stays fixed.
                          Visibility(
                            visible: scrollTitle,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                context.copy('action.login'),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                          NoticeCard(
                            notice: widget.controller.notice,
                            onDismiss: widget.controller.clearNotice,
                          ),
                          if (widget.controller.notice != null)
                            const SizedBox(height: 16),
                          _LoginForm(controller: widget.controller, busy: busy),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({
    super.key,
    required this.controller,
    this.loginOnly = false,
  });

  final VpnAppController controller;
  final bool loginOnly;

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    widget.controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (!mounted) return;
    setState(() {});
    if (!widget.loginOnly ||
        !widget.controller.isSignedIn ||
        widget.controller.profile?.isGuest != false ||
        widget.controller.profile?.profileRedacted != false) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && ModalRoute.of(context)?.isCurrent == true) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool busy = widget.controller.isAuthenticating;
    return Scaffold(
      appBar: widget.loginOnly
          ? AppBar(title: Text(context.copy('action.login')))
          : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool wide = constraints.maxWidth >= 840;
            final Widget authPanel = _AuthPanel(
              controller: widget.controller,
              tabs: _tabs,
              busy: busy,
              showCompactBrand: !wide,
              loginOnly: widget.loginOnly,
            );
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: wide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Expanded(child: _BrandIntroduction()),
                          Expanded(child: authPanel),
                        ],
                      )
                    : authPanel,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BrandIntroduction extends StatelessWidget {
  const _BrandIntroduction();

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: FuzeVpnTheme.ink,
    child: FuzeNetworkGrid(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(48),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const FuzeBrand(emblemSize: 44, color: FuzeVpnTheme.paper),
              const SizedBox(height: 80),
              const FuzeEyebrow('Android', color: FuzeVpnTheme.signal),
              const SizedBox(height: 20),
              Text(
                context.copy('auth.tagline'),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 48,
                  height: 1.15,
                  color: FuzeVpnTheme.paper,
                ),
              ),
              const SizedBox(height: 28),
              Container(width: 48, height: 3, color: FuzeVpnTheme.signal),
              const SizedBox(height: 28),
              Text(
                context.copy('auth.keysLocal'),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: const Color(0xFFC6BEB2)),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: FuzeVpnTheme.signal,
                  border: Border.all(
                    color: FuzeVpnTheme.signal.withValues(alpha: .4),
                    width: 8,
                  ),
                ),
                child: const FuzeEmblem(size: 60, color: FuzeVpnTheme.ink),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _AuthPanel extends StatelessWidget {
  const _AuthPanel({
    required this.controller,
    required this.tabs,
    required this.busy,
    required this.showCompactBrand,
    required this.loginOnly,
  });

  final VpnAppController controller;
  final TabController tabs;
  final bool busy;
  final bool showCompactBrand;
  final bool loginOnly;

  @override
  Widget build(BuildContext context) => ListView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    padding: EdgeInsets.fromLTRB(
      showCompactBrand ? 20 : 48,
      showCompactBrand ? 20 : 48,
      showCompactBrand ? 20 : 48,
      40,
    ),
    children: <Widget>[
      if (showCompactBrand) ...<Widget>[
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: <Widget>[
            const FuzeBrand(emblemSize: 32),
            LanguageSettings(
              key: const ValueKey('auth-language-settings'),
              locale: controller.locale,
              onChanged: controller.setLocale,
              compact: true,
            ),
          ],
        ),
        const SizedBox(height: 24),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ColoredBox(
            color: FuzeVpnTheme.ink,
            child: FuzeNetworkGrid(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const FuzeEyebrow('Android', color: FuzeVpnTheme.signal),
                    const SizedBox(height: 14),
                    Text(
                      context.copy('auth.welcome'),
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: FuzeVpnTheme.paper, fontSize: 30),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.copy('auth.tagline'),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFC6BEB2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ] else ...<Widget>[
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: LanguageSettings(
            key: const ValueKey('auth-language-settings'),
            locale: controller.locale,
            onChanged: controller.setLocale,
            compact: true,
          ),
        ),
        const SizedBox(height: 28),
        FuzePageHeader(
          title: context.copy('auth.welcome'),
          description: context.copy('auth.tagline'),
          compact: true,
        ),
      ],
      NoticeCard(notice: controller.notice, onDismiss: controller.clearNotice),
      if (controller.notice != null) const SizedBox(height: 20),
      if (!loginOnly)
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(FuzeVpnTheme.cornerRadius),
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: TabBar(
            controller: tabs,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicatorPadding: const EdgeInsets.all(4),
            indicator: BoxDecoration(
              color: FuzeVpnTheme.signal,
              borderRadius: BorderRadius.circular(
                FuzeVpnTheme.cornerRadius - 2,
              ),
            ),
            labelColor: FuzeVpnTheme.ink,
            isScrollable: MediaQuery.textScalerOf(context).scale(1) > 1.3,
            tabAlignment: MediaQuery.textScalerOf(context).scale(1) > 1.3
                ? TabAlignment.start
                : TabAlignment.fill,
            tabs: <Widget>[
              Tab(text: context.copy('auth.tab.login')),
              Tab(text: context.copy('auth.tab.register')),
            ],
          ),
        ),
      const SizedBox(height: 28),
      if (loginOnly)
        _LoginForm(controller: controller, busy: busy)
      else
        AnimatedBuilder(
          animation: tabs,
          builder: (BuildContext context, Widget? child) => IndexedStack(
            index: tabs.index,
            children: <Widget>[
              _LoginForm(
                controller: controller,
                busy: busy,
                onCreateAccount: () => tabs.animateTo(1),
              ),
              _RegistrationForm(
                controller: controller,
                busy: busy,
                active: tabs.index == 1,
              ),
            ],
          ),
        ),
      if (showCompactBrand) ...<Widget>[
        const SizedBox(height: 28),
        Divider(color: Theme.of(context).colorScheme.outline),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.lock_outline,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                context.copy('auth.keysLocal'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ],
      const SizedBox(height: 16),
      TextButton.icon(
        onPressed: () => Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => DiagnosticsPage(controller: controller),
          ),
        ),
        icon: const Icon(Icons.health_and_safety_outlined),
        label: Text(context.copy('diagnostics.title')),
      ),
    ],
  );
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({
    required this.controller,
    required this.busy,
    this.onCreateAccount,
  });

  final VpnAppController controller;
  final bool busy;
  final VoidCallback? onCreateAccount;

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final bool signedIn = await widget.controller.signIn(
      email: _email.text.trim(),
      password: _password.text,
    );
    if (signedIn) TextInput.finishAutofillContext();
  }

  @override
  Widget build(BuildContext context) => AutofillGroup(
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GoogleSignInButton(
            key: const ValueKey('auth-google'),
            onPressed: widget.busy
                ? null
                : () => openGoogleAuthentication(
                    context,
                    widget.controller,
                    GoogleAuthPurpose.authenticate,
                  ),
          ),
          const GoogleAuthMethodsDivider(),
          TextFormField(
            key: const ValueKey('auth-login-email'),
            controller: _email,
            enabled: !widget.busy,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const <String>[
              AutofillHints.username,
              AutofillHints.email,
            ],
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: context.copy('form.email')),
            validator: (String? value) => _emailValidator(context, value),
          ),
          const SizedBox(height: 14),
          TextFormField(
            key: const ValueKey('auth-login-password'),
            controller: _password,
            enabled: !widget.busy,
            obscureText: _obscurePassword,
            autofillHints: const <String>[AutofillHints.password],
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: context.copy('form.password'),
              suffixIcon: IconButton(
                tooltip: _obscurePassword
                    ? context.copy('form.showPassword')
                    : context.copy('form.hidePassword'),
                onPressed: widget.busy
                    ? null
                    : () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
            validator: (String? value) => value == null || value.isEmpty
                ? context.copy('validation.required')
                : null,
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            key: const ValueKey('auth-login-submit'),
            onPressed: widget.busy ? null : _submit,
            icon: widget.busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.arrow_forward),
            label: Text(context.copy('action.login')),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: widget.busy
                  ? null
                  : () => _showPasswordResetSheet(context, widget.controller),
              child: Text(context.copy('action.forgotPassword')),
            ),
          ),
          if (widget.onCreateAccount != null) ...<Widget>[
            const SizedBox(height: 10),
            Divider(color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 18),
            Text(
              context.copy('auth.noAccount'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: widget.busy ? null : widget.onCreateAccount,
              child: Text(context.copy('action.createAccount')),
            ),
          ],
        ],
      ),
    ),
  );
}

class _RegistrationForm extends StatefulWidget {
  const _RegistrationForm({
    required this.controller,
    required this.busy,
    required this.active,
  });

  final VpnAppController controller;
  final bool busy;
  final bool active;

  @override
  State<_RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<_RegistrationForm> {
  static const int _stepCount = 3;

  final List<GlobalKey<FormState>> _formKeys =
      List<GlobalKey<FormState>>.generate(
        _stepCount,
        (_) => GlobalKey<FormState>(),
      );
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address1 = TextEditingController();
  final TextEditingController _address2 = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController(text: 'FR');
  int _step = 0;
  bool _termsAccepted = false;
  bool _privacyAccepted = false;
  bool _showConsentErrors = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    for (final TextEditingController controller in <TextEditingController>[
      _email,
      _password,
      _firstName,
      _lastName,
      _phone,
      _address1,
      _address2,
      _postalCode,
      _city,
      _country,
    ]) {
      controller.clear();
      controller.dispose();
    }
    super.dispose();
  }

  void _previous() {
    if (_step == 0 || widget.busy) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _showConsentErrors = false;
      _step -= 1;
    });
  }

  void _next() {
    if (widget.busy || !_formKeys[_step].currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _step += 1);
  }

  Future<void> _submit() async {
    final bool valid = _formKeys[_step].currentState!.validate();
    final bool consentsValid = _termsAccepted && _privacyAccepted;
    if (!valid || !consentsValid) {
      setState(() => _showConsentErrors = true);
      return;
    }
    FocusScope.of(context).unfocus();
    final bool registered = await widget.controller.register(
      RegisterAccountRequest(
        email: _email.text.trim(),
        password: _password.text,
        firstName: _firstName.text.trim(),
        lastName: _lastName.text.trim(),
        phone: _phone.text.trim(),
        addressLine1: _address1.text.trim(),
        addressLine2: _address2.text.trim(),
        postalCode: _postalCode.text.trim(),
        city: _city.text.trim(),
        countryCode: _country.text.trim().toUpperCase(),
        termsAccepted: _termsAccepted,
        privacyAccepted: _privacyAccepted,
      ),
    );
    if (registered) TextInput.finishAutofillContext();
  }

  @override
  Widget build(BuildContext context) {
    final bool reduceMotion =
        MediaQuery.disableAnimationsOf(context) ||
        MediaQuery.accessibleNavigationOf(context);
    return PopScope(
      canPop: !widget.active || _step == 0,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop && widget.active) _previous();
      },
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _RegistrationProgress(step: _step),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: reduceMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 180),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: KeyedSubtree(
                key: ValueKey<int>(_step),
                child: switch (_step) {
                  0 => _accountStep(context),
                  1 => _identityStep(context),
                  _ => _addressStep(context),
                },
              ),
            ),
            const SizedBox(height: 22),
            _RegistrationActions(
              step: _step,
              busy: widget.busy,
              onPrevious: _previous,
              onNext: _next,
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountStep(BuildContext context) => Form(
    key: _formKeys[0],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          context.copy('auth.requiredInformation'),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 18),
        _field(
          _email,
          context.copy('form.email'),
          (String? value) => _emailValidator(context, value),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const <String>[AutofillHints.email],
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _password,
          enabled: !widget.busy,
          obscureText: _obscurePassword,
          autofillHints: const <String>[AutofillHints.newPassword],
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _next(),
          decoration: InputDecoration(
            labelText: context.copy('form.password'),
            helper: Text(
              context.copy('form.passwordMin'),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            suffixIcon: IconButton(
              tooltip: _obscurePassword
                  ? context.copy('form.showPassword')
                  : context.copy('form.hidePassword'),
              onPressed: widget.busy
                  ? null
                  : () => setState(() => _obscurePassword = !_obscurePassword),
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          validator: (String? value) => switch (validatePasswordLength(value)) {
            PasswordLengthIssue.tooShort => context.copy('validation.password'),
            PasswordLengthIssue.tooLong => context.copy(
              'validation.passwordTooLong',
            ),
            null => null,
          },
          errorBuilder: (BuildContext context, String message) => Text(
            message,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _identityStep(BuildContext context) => Form(
    key: _formKeys[1],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _field(
          _firstName,
          context.copy('form.firstName'),
          (String? value) => _requiredValidator(context, value),
          textInputAction: TextInputAction.next,
          autofillHints: const <String>[AutofillHints.givenName],
        ),
        const SizedBox(height: 14),
        _field(
          _lastName,
          context.copy('form.lastName'),
          (String? value) => _requiredValidator(context, value),
          textInputAction: TextInputAction.next,
          autofillHints: const <String>[AutofillHints.familyName],
        ),
        const SizedBox(height: 14),
        _field(
          _phone,
          context.copy('form.phone'),
          (String? value) => _phoneValidator(context, value),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _next(),
          autofillHints: const <String>[AutofillHints.telephoneNumber],
        ),
      ],
    ),
  );

  Widget _addressStep(BuildContext context) => Form(
    key: _formKeys[2],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _field(
          _address1,
          context.copy('form.address'),
          (String? value) => _requiredValidator(context, value),
          textInputAction: TextInputAction.next,
          autofillHints: const <String>[AutofillHints.streetAddressLine1],
        ),
        const SizedBox(height: 14),
        _field(
          _address2,
          context.copy('form.address2'),
          null,
          textInputAction: TextInputAction.next,
          autofillHints: const <String>[AutofillHints.streetAddressLine2],
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget postalCode = _field(
              _postalCode,
              context.copy('form.postalCode'),
              (String? value) => _requiredValidator(context, value),
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.postalCode],
            );
            final Widget city = _field(
              _city,
              context.copy('form.city'),
              (String? value) => _requiredValidator(context, value),
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.addressCity],
            );
            if (constraints.maxWidth < 460) {
              return Column(
                children: <Widget>[
                  postalCode,
                  const SizedBox(height: 14),
                  city,
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: postalCode),
                const SizedBox(width: 14),
                Expanded(child: city),
              ],
            );
          },
        ),
        const SizedBox(height: 14),
        _field(
          _country,
          context.copy('form.country'),
          (String? value) => _countryValidator(context, value),
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.done,
          autofillHints: const <String>[AutofillHints.countryCode],
        ),
        const SizedBox(height: 16),
        _LegalConsentTile(
          id: 'terms',
          value: _termsAccepted,
          onChanged: widget.busy
              ? null
              : (bool? value) => setState(() {
                  _termsAccepted = value ?? false;
                  if (_termsAccepted) _showConsentErrors = false;
                }),
          prefix: context.copy('auth.termsPrefix'),
          linkText: context.copy('auth.termsLink'),
          url: PublicLinks.terms(Localizations.localeOf(context)),
          showError: _showConsentErrors && !_termsAccepted,
        ),
        _LegalConsentTile(
          id: 'privacy',
          value: _privacyAccepted,
          onChanged: widget.busy
              ? null
              : (bool? value) => setState(() {
                  _privacyAccepted = value ?? false;
                  if (_privacyAccepted) _showConsentErrors = false;
                }),
          prefix: context.copy('auth.privacyPrefix'),
          linkText: context.copy('auth.privacyLink'),
          url: PublicLinks.privacy(Localizations.localeOf(context)),
          showError: _showConsentErrors && !_privacyAccepted,
        ),
      ],
    ),
  );

  Widget _field(
    TextEditingController controller,
    String label,
    String? Function(String?)? validator, {
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    ValueChanged<String>? onFieldSubmitted,
    Iterable<String>? autofillHints,
  }) => TextFormField(
    controller: controller,
    enabled: !widget.busy,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    textInputAction: textInputAction,
    onFieldSubmitted: onFieldSubmitted,
    autofillHints: autofillHints,
    decoration: InputDecoration(labelText: label),
    validator: validator,
  );
}

class _RegistrationProgress extends StatelessWidget {
  const _RegistrationProgress({required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    final List<String> labels = <String>[
      context.copy('auth.step.account'),
      context.copy('auth.step.identity'),
      context.copy('auth.step.address'),
    ];
    final String progress = context.copy(
      'auth.step.progress',
      arguments: <String, Object?>{'current': step + 1, 'total': labels.length},
    );
    return Semantics(
      label: '$progress. ${labels[step]}',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final Widget title = Text(
                  labels[step],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                );
                final Widget counter = Text(
                  progress,
                  style: FuzeVpnTheme.mono(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                );
                if (constraints.maxWidth < 400 ||
                    MediaQuery.textScalerOf(context).scale(1) > 1.3) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      counter,
                      const SizedBox(height: 8),
                      title,
                    ],
                  );
                }
                return Row(
                  children: <Widget>[
                    Expanded(child: title),
                    const SizedBox(width: 12),
                    counter,
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: (step + 1) / labels.length),
          ],
        ),
      ),
    );
  }
}

class _RegistrationActions extends StatelessWidget {
  const _RegistrationActions({
    required this.step,
    required this.busy,
    required this.onPrevious,
    required this.onNext,
    required this.onSubmit,
  });

  final int step;
  final bool busy;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final Widget primaryAction = FilledButton.icon(
      onPressed: busy
          ? null
          : step == 2
          ? onSubmit
          : onNext,
      icon: busy && step == 2
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(step == 2 ? Icons.check : Icons.arrow_forward),
      label: Text(
        step == 2
            ? context.copy('action.createMyAccount')
            : context.copy('action.next'),
      ),
    );
    if (step == 0) return primaryAction;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Widget back = OutlinedButton(
          onPressed: busy ? null : onPrevious,
          child: Text(context.copy('action.previous')),
        );
        if (constraints.maxWidth < 380) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[primaryAction, const SizedBox(height: 10), back],
          );
        }
        return Row(
          children: <Widget>[
            Expanded(child: back),
            const SizedBox(width: 12),
            Expanded(flex: 2, child: primaryAction),
          ],
        );
      },
    );
  }
}

/// A checkbox and its document link are separate accessibility controls. A
/// CheckboxListTile would merge the link's action into the checkbox node.
class _LegalConsentTile extends StatelessWidget {
  const _LegalConsentTile({
    required this.id,
    required this.value,
    required this.onChanged,
    required this.prefix,
    required this.linkText,
    required this.url,
    required this.showError,
  });

  final String id;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String prefix;
  final String linkText;
  final Uri url;
  final bool showError;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Semantics(
          container: true,
          child: Checkbox(
            key: ValueKey('registration-$id-consent'),
            value: value,
            onChanged: onChanged,
            semanticLabel: '$prefix$linkText.',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _LegalConsent(
                linkKey: ValueKey('registration-$id-link'),
                prefix: prefix,
                linkText: linkText,
                url: url,
              ),
              if (showError)
                Semantics(
                  liveRegion: true,
                  child: Text(
                    context.copy('auth.consentRequired'),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _LegalConsent extends StatelessWidget {
  const _LegalConsent({
    required this.linkKey,
    required this.prefix,
    required this.linkText,
    required this.url,
  });

  final Key linkKey;
  final String prefix;
  final String linkText;
  final Uri url;

  @override
  Widget build(BuildContext context) => Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: <Widget>[
      ExcludeSemantics(child: Text(prefix)),
      Semantics(
        key: linkKey,
        container: true,
        link: true,
        label: linkText,
        onTap: () => openExternalLink(context, url),
        child: ExcludeSemantics(
          child: InkWell(
            borderRadius: BorderRadius.circular(FuzeVpnTheme.cornerRadius),
            onTap: () => openExternalLink(context, url),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                linkText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
      const ExcludeSemantics(child: Text('.')),
    ],
  );
}

Future<void> _showPasswordResetSheet(
  BuildContext context,
  VpnAppController controller,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) => _PasswordResetSheet(controller: controller),
);

class _PasswordResetSheet extends StatefulWidget {
  const _PasswordResetSheet({required this.controller});

  final VpnAppController controller;

  @override
  State<_PasswordResetSheet> createState() => _PasswordResetSheetState();
}

class _PasswordResetSheetState extends State<_PasswordResetSheet> {
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _sending = false;
  AppNotice? _notice;

  @override
  void dispose() {
    _email.clear();
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_sending || !_formKey.currentState!.validate()) return;
    setState(() {
      _sending = true;
      _notice = null;
    });
    final bool sent = await widget.controller.requestPasswordReset(
      _email.text.trim(),
    );
    if (!mounted || ModalRoute.of(context)?.isCurrent != true) return;
    if (sent) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _sending = false;
        _notice = widget.controller.notice;
      });
      // The modal owns this failure while it is open. A response received
      // after dismissal stays on the authentication page instead.
      if (_notice != null && identical(widget.controller.notice, _notice)) {
        widget.controller.clearNotice();
      }
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        28,
        24,
        MediaQuery.viewInsetsOf(context).bottom + 28,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              context.copy('passwordReset.title'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(context.copy('passwordReset.description')),
            if (_notice != null) ...<Widget>[
              const SizedBox(height: 16),
              NoticeCard(
                notice: _notice,
                onDismiss: () => setState(() => _notice = null),
              ),
            ],
            const SizedBox(height: 20),
            TextFormField(
              controller: _email,
              enabled: !_sending,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const <String>[AutofillHints.email],
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: context.copy('form.email'),
              ),
              validator: (String? value) => _emailValidator(context, value),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: _sending ? null : _submit,
              child: Text(context.copy('passwordReset.send')),
            ),
          ],
        ),
      ),
    ),
  );
}

String? _requiredValidator(BuildContext context, String? value) =>
    value == null || value.trim().isEmpty
    ? context.copy('validation.required')
    : null;

String? _emailValidator(BuildContext context, String? value) {
  final String candidate = value?.trim() ?? '';
  return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(candidate)
      ? null
      : context.copy('validation.email');
}

String? _phoneValidator(BuildContext context, String? value) =>
    RegExp(r'^\+[1-9][0-9]{7,14}$').hasMatch(value?.trim() ?? '')
    ? null
    : context.copy('validation.phone');

String? _countryValidator(BuildContext context, String? value) =>
    RegExp(r'^[A-Za-z]{2}$').hasMatch(value?.trim() ?? '')
    ? null
    : context.copy('validation.country');
