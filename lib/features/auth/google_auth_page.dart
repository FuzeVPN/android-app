import 'dart:async';

import 'package:flutter/material.dart';
import '../../app_controller.dart';
import '../../core/country_data.dart';
import '../../core/public_links.dart';
import '../../google_auth_controller.dart';
import '../../l10n/app_copy.dart';
import '../../l10n/translated_countries.dart';
import '../../widgets/external_link.dart';
import '../../widgets/fuze_brand.dart';
import '../../widgets/fuze_design.dart';
import '../../widgets/google_sign_in_button.dart';

Future<void> openGoogleAuthentication(
  BuildContext context,
  VpnAppController controller,
  GoogleAuthPurpose purpose,
) => Navigator.of(context).push<void>(
  MaterialPageRoute<void>(
    builder: (_) =>
        GoogleAuthenticationPage(controller: controller, purpose: purpose),
  ),
);

/// Entry is an explicit provider-button action. No account prompt is shown by
/// Welcome, startup, settings refresh, or a background billing restoration.
class GoogleAuthenticationPage extends StatefulWidget {
  const GoogleAuthenticationPage({
    super.key,
    required this.controller,
    required this.purpose,
  });
  final VpnAppController controller;
  final GoogleAuthPurpose purpose;

  @override
  State<GoogleAuthenticationPage> createState() =>
      _GoogleAuthenticationPageState();
}

class _GoogleAuthenticationPageState extends State<GoogleAuthenticationPage> {
  final _profileForm = GlobalKey<FormState>();
  final _proofForm = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _emailCode = TextEditingController();
  String? _country;
  bool _terms = false, _privacy = false, _showConsentErrors = false;
  bool _obscure = true, _closing = false, _allowPop = false, _finishing = false;
  String? _exitMessage;
  Timer? _retryTimer;

  GoogleAuthController get _auth => widget.controller.googleAuth;

  @override
  void initState() {
    super.initState();
    _auth.addListener(_changed);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(_auth.begin(widget.purpose));
      }
    });
  }

  void _changed() {
    if (!mounted) {
      return;
    }
    _retryTimer?.cancel();
    final retry = _auth.state.retryAfter;
    if (retry != null && retry.isAfter(DateTime.now())) {
      _retryTimer = Timer(retry.difference(DateTime.now()), () {
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
    if (_auth.state.step == GoogleAuthStep.authenticated && !_finishing) {
      _finishing = true;
      _allowPop = true;
      _password.clear();
      _emailCode.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && ModalRoute.of(context)?.isCurrent == true) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      });
    }
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    _auth.removeListener(_changed);
    _password.clear();
    _emailCode.clear();
    _password.dispose();
    _emailCode.dispose();
    super.dispose();
  }

  Future<void> _leave() async {
    if (_closing) {
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _closing = true;
      _exitMessage = null;
    });
    final cancelled = await _auth.cancel();
    if (!mounted) {
      return;
    }
    if (_finishing) {
      return;
    }
    if (!cancelled) {
      setState(() {
        _closing = false;
        _exitMessage = 'google.cancelFailed';
      });
      return;
    }
    setState(() => _allowPop = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_finishing && ModalRoute.of(context)?.isCurrent == true) {
        Navigator.of(context).pop();
      }
    });
  }

  Future<void> _completeProfile() async {
    final valid = _profileForm.currentState?.validate() == true;
    if (!valid || !_terms || !_privacy) {
      setState(() => _showConsentErrors = true);
      return;
    }
    FocusScope.of(context).unfocus();
    await _auth.completeProfile(
      countryCode: _country!,
      termsAccepted: _terms,
      privacyAccepted: _privacy,
    );
  }

  Future<void> _provePassword() async {
    if (_proofForm.currentState?.validate() != true) {
      return;
    }
    FocusScope.of(context).unfocus();
    await _auth.linkWithPassword(_password.text);
  }

  Future<void> _confirmEmail() async {
    if (_proofForm.currentState?.validate() != true) {
      return;
    }
    FocusScope.of(context).unfocus();
    await _auth.confirmEmailLink(_emailCode.text.trim());
  }

  Future<void> _restart() async {
    if (!await _auth.cancel() || !mounted) {
      if (mounted) {
        setState(() => _exitMessage = 'google.cancelFailed');
      }
      return;
    }
    _password.clear();
    _emailCode.clear();
    setState(() {
      _exitMessage = null;
      _country = null;
      _terms = false;
      _privacy = false;
      _showConsentErrors = false;
    });
    await _auth.begin(widget.purpose);
  }

  @override
  Widget build(BuildContext context) {
    final state = _auth.state;
    final busy = _auth.isBusy || _closing;
    final profileStep =
        state.step == GoogleAuthStep.registrationRequired ||
        state.step == GoogleAuthStep.guestClaimRequired;
    return PopScope<void>(
      canPop: _allowPop,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          unawaited(_leave());
        }
      },
      child: Scaffold(
        key: const ValueKey('google-auth-page'),
        appBar: AppBar(
          leading: BackButton(onPressed: _closing ? null : _leave),
          title: const FuzeBrand(emblemSize: 28),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: ListView(
                key: const ValueKey('google-auth-scroll'),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(24),
                children: [
                  FuzePageHeader(
                    compact:
                        MediaQuery.sizeOf(context).width < 360 ||
                        MediaQuery.textScalerOf(context).scale(1) > 1.5,
                    title: context.copy(
                      profileStep
                          ? 'google.settingUp'
                          : state.step == GoogleAuthStep.linkRequired
                          ? 'google.linkTitle'
                          : 'google.title',
                    ),
                    description: profileStep
                        ? context.copy(
                            widget.purpose == GoogleAuthPurpose.claim
                                ? 'google.claimDescription'
                                : 'google.profileDescription',
                          )
                        : state.step == GoogleAuthStep.linkRequired
                        ? context.copy('google.linkDescription')
                        : null,
                  ),
                  if (state.context?.email case final String email
                      when email.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        email,
                        key: const ValueKey('google-selected-email'),
                        textDirection: TextDirection.ltr,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  if (state.messageKey != null || _exitMessage != null) ...[
                    Semantics(
                      liveRegion: true,
                      child: FuzePanel(
                        tone: FuzePanelTone.wash,
                        child: Text(
                          context.copy(_exitMessage ?? state.messageKey!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (busy)
                    Semantics(
                      liveRegion: true,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              context.copy(
                                state.step == GoogleAuthStep.selectingAccount
                                    ? 'google.selecting'
                                    : 'google.verifying',
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (profileStep)
                    _profile(context)
                  else if (state.step == GoogleAuthStep.linkRequired)
                    _proof(context)
                  else if (state.step == GoogleAuthStep.uncertain) ...[
                    FilledButton(
                      key: const ValueKey('google-resume'),
                      onPressed: _auth.resume,
                      child: Text(
                        context.copy('google.resume'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ] else if (state.step == GoogleAuthStep.failure ||
                      state.step == GoogleAuthStep.idle) ...[
                    GoogleSignInButton(
                      key: const ValueKey('google-restart'),
                      onPressed: _restart,
                    ),
                  ],
                  const SizedBox(height: 20),
                  TextButton(
                    key: const ValueKey('google-cancel'),
                    onPressed: _closing ? null : _leave,
                    child: Text(
                      context.copy(
                        widget.purpose == GoogleAuthPurpose.claim
                            ? 'guest.skip'
                            : 'action.cancel',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profile(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final names = translatedCountryNames[locale] ?? countryNames['en']!;
    // CLDR also contains reserved regions; XK is accepted by the API.
    const excluded = {
      'AC',
      'CP',
      'CQ',
      'DG',
      'EA',
      'EU',
      'EZ',
      'IC',
      'QO',
      'TA',
      'UN',
      'XA',
      'XB',
      'ZZ',
    };
    final codes =
        names.keys
            .where(
              (code) =>
                  RegExp(r'^[A-Z]{2}$').hasMatch(code) &&
                  !excluded.contains(code),
            )
            .toList()
          ..sort((a, b) => names[a]!.compareTo(names[b]!));
    return Form(
      key: _profileForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            key: const ValueKey('google-country'),
            initialValue: _country,
            isExpanded: true,
            itemHeight: null,
            menuMaxHeight: MediaQuery.sizeOf(context).height * .55,
            decoration: InputDecoration(
              labelText: context.copy('google.country'),
            ),
            items: codes
                .map(
                  (code) =>
                      DropdownMenuItem(value: code, child: Text(names[code]!)),
                )
                .toList(),
            onChanged: (value) => setState(() => _country = value),
            validator: (value) =>
                value == null ? context.copy('validation.country') : null,
          ),
          const SizedBox(height: 20),
          _consent(context, terms: true),
          _consent(context, terms: false),
          const SizedBox(height: 20),
          FilledButton(
            key: const ValueKey('google-profile-submit'),
            onPressed: _completeProfile,
            child: Text(
              context.copy('action.createMyAccount'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _consent(BuildContext context, {required bool terms}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          key: ValueKey(
            terms ? 'google-terms-consent' : 'google-privacy-consent',
          ),
          value: terms ? _terms : _privacy,
          semanticLabel:
              '${context.copy(terms ? 'auth.termsPrefix' : 'auth.privacyPrefix')}${context.copy(terms ? 'auth.termsLink' : 'auth.privacyLink')}',
          onChanged: (value) => setState(() {
            if (terms) {
              _terms = value ?? false;
            } else {
              _privacy = value ?? false;
            }
          }),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.copy(terms ? 'auth.termsPrefix' : 'auth.privacyPrefix'),
              ),
              TextButton(
                key: ValueKey(
                  terms ? 'google-terms-link' : 'google-privacy-link',
                ),
                onPressed: () => openExternalLink(
                  context,
                  terms
                      ? PublicLinks.terms(Localizations.localeOf(context))
                      : PublicLinks.privacy(Localizations.localeOf(context)),
                ),
                child: Text(
                  context.copy(terms ? 'auth.termsLink' : 'auth.privacyLink'),
                  textAlign: TextAlign.start,
                ),
              ),
              if (_showConsentErrors && !(terms ? _terms : _privacy))
                Semantics(
                  liveRegion: true,
                  child: Text(
                    context.copy('auth.consentRequired'),
                    style: TextStyle(
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

  Widget _proof(BuildContext context) => Form(
    key: _proofForm,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_auth.state.emailRequested) ...[
          Text(context.copy('google.emailInstructions')),
          const SizedBox(height: 16),
          TextFormField(
            key: const ValueKey('google-email-code'),
            controller: _emailCode,
            decoration: InputDecoration(
              labelText: context.copy('google.emailCode'),
            ),
            textDirection: TextDirection.ltr,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.visiblePassword,
            textCapitalization: TextCapitalization.characters,
            validator: (value) => value == null || value.trim().isEmpty
                ? context.copy('validation.required')
                : null,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _confirmEmail(),
          ),
          const SizedBox(height: 20),
          FilledButton(
            key: const ValueKey('google-email-confirm'),
            onPressed: _confirmEmail,
            child: Text(
              context.copy('google.confirmEmail'),
              textAlign: TextAlign.center,
            ),
          ),
        ] else ...[
          TextFormField(
            key: const ValueKey('google-fuze-password'),
            controller: _password,
            obscureText: _obscure,
            autocorrect: false,
            enableSuggestions: false,
            autofillHints: const [AutofillHints.password],
            decoration: InputDecoration(
              labelText: context.copy('google.password'),
              suffixIcon: IconButton(
                tooltip: context.copy(
                  _obscure ? 'form.showPassword' : 'form.hidePassword',
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
            validator: (value) => value == null || value.isEmpty
                ? context.copy('validation.required')
                : null,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _provePassword(),
          ),
          const SizedBox(height: 20),
          FilledButton(
            key: const ValueKey('google-password-confirm'),
            onPressed: _provePassword,
            child: Text(
              context.copy('google.linkAccount'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        const SizedBox(height: 12),
        OutlinedButton(
          key: const ValueKey('google-email-request'),
          onPressed: _auth.state.retryAfter?.isAfter(DateTime.now()) == true
              ? null
              : _auth.requestEmailLink,
          child: Text(
            context.copy('google.requestEmail'),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
