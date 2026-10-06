import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_controller.dart';
import '../../core/password_policy.dart';
import '../../core/public_links.dart';
import '../../google_auth_controller.dart';
import '../../l10n/app_copy.dart';
import '../../widgets/external_link.dart';
import '../../widgets/fuze_brand.dart';
import '../../widgets/fuze_design.dart';
import '../../widgets/google_sign_in_button.dart';
import '../../widgets/notice_card.dart';
import 'auth_page.dart';
import 'google_auth_page.dart';

/// Linking an existing guest identity never requires the former web form.
class GuestClaimPage extends StatefulWidget {
  const GuestClaimPage({super.key, required this.controller});
  final VpnAppController controller;

  @override
  State<GuestClaimPage> createState() => _GuestClaimPageState();
}

class _GuestClaimPageState extends State<GuestClaimPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (widget.controller.isGuestActionBusy ||
        _form.currentState?.validate() != true) {
      return;
    }
    FocusScope.of(context).unfocus();
    final claimed = await widget.controller.claimGuestAccount(
      email: _email.text.trim(),
      password: _password.text,
    );
    if (!mounted || !claimed) return;
    TextInput.finishAutofillContext();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.controller,
    builder: (context, _) {
      final busy = widget.controller.isGuestActionBusy;
      final canClaim =
          widget.controller.profile?.isGuest == true &&
          widget.controller.profile?.canClaimAccount == true;
      return Scaffold(
        key: const ValueKey('guest-claim-page'),
        appBar: AppBar(title: const FuzeBrand(emblemSize: 28)),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: ListView(
                padding: const EdgeInsets.all(24),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  FuzePageHeader(
                    title: context.copy('guest.claimTitle'),
                    description: context.copy('guest.claimDescription'),
                  ),
                  if (widget.controller.notice != null) ...[
                    NoticeCard(
                      notice: widget.controller.notice,
                      onDismiss: widget.controller.clearNotice,
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (widget.controller.guestMessageKey != null) ...[
                    Semantics(
                      liveRegion: true,
                      child: FuzePanel(
                        child: Text(
                          context.copy(widget.controller.guestMessageKey!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (canClaim) ...[
                    GoogleSignInButton(
                      key: const ValueKey('guest-claim-google'),
                      onPressed: busy
                          ? null
                          : () => openGoogleAuthentication(
                              context,
                              widget.controller,
                              GoogleAuthPurpose.claim,
                            ),
                    ),
                    const GoogleAuthMethodsDivider(),
                    AutofillGroup(
                      child: Form(
                        key: _form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              key: const ValueKey('guest-claim-email'),
                              controller: _email,
                              enabled: !busy,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [
                                AutofillHints.email,
                                AutofillHints.newUsername,
                              ],
                              decoration: InputDecoration(
                                labelText: context.copy('form.email'),
                              ),
                              validator: (value) =>
                                  RegExp(
                                    r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                                  ).hasMatch(value?.trim() ?? '')
                                  ? null
                                  : context.copy('validation.email'),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              key: const ValueKey('guest-claim-password'),
                              controller: _password,
                              enabled: !busy,
                              obscureText: _obscure,
                              autocorrect: false,
                              enableSuggestions: false,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _submit(),
                              autofillHints: const [AutofillHints.newPassword],
                              decoration: InputDecoration(
                                labelText: context.copy('form.password'),
                                helperText: context.copy('form.passwordMin'),
                                helperMaxLines: 5,
                                suffixIcon: IconButton(
                                  tooltip: context.copy(
                                    _obscure
                                        ? 'form.showPassword'
                                        : 'form.hidePassword',
                                  ),
                                  onPressed: busy
                                      ? null
                                      : () => setState(
                                          () => _obscure = !_obscure,
                                        ),
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                              ),
                              validator: (value) =>
                                  switch (validatePasswordLength(value)) {
                                    PasswordLengthIssue.tooShort =>
                                      context.copy('validation.password'),
                                    PasswordLengthIssue.tooLong => context.copy(
                                      'validation.passwordTooLong',
                                    ),
                                    null => null,
                                  },
                            ),
                            const SizedBox(height: 20),
                            const OnboardingLegalLinks(),
                            const SizedBox(height: 20),
                            FilledButton(
                              key: const ValueKey('guest-claim-submit'),
                              onPressed: busy ? null : _submit,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 12,
                                children: [
                                  if (busy)
                                    const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  Text(
                                    context.copy('action.createMyAccount'),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (const {
                    'guest.emailExists',
                    'guest.loginRequired',
                  }.contains(widget.controller.guestMessageKey)) ...[
                    const SizedBox(height: 12),
                    OutlinedButton(
                      key: const ValueKey('guest-claim-sign-in'),
                      onPressed: busy
                          ? null
                          : () => Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (_) => AuthenticationPage(
                                  controller: widget.controller,
                                  loginOnly: true,
                                ),
                              ),
                            ),
                      child: Text(
                        context.copy('action.login'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  TextButton(
                    key: const ValueKey('guest-claim-skip'),
                    onPressed: busy
                        ? null
                        : () => Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst),
                    child: Text(
                      context.copy('guest.skip'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// Both documents are independent links, reachable by touch and TalkBack.
class OnboardingLegalLinks extends StatelessWidget {
  const OnboardingLegalLinks({
    super.key,
    this.showAcceptance = true,
    this.centered = false,
  });

  final bool showAcceptance;
  final bool centered;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if (showAcceptance)
        Text(
          context.copy('billing.acceptance'),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      Wrap(
        alignment: centered ? WrapAlignment.center : WrapAlignment.start,
        spacing: 12,
        children: [
          TextButton(
            key: const ValueKey('onboarding-terms'),
            onPressed: () => openExternalLink(
              context,
              PublicLinks.terms(Localizations.localeOf(context)),
            ),
            child: Text(context.copy('auth.termsLink')),
          ),
          TextButton(
            key: const ValueKey('onboarding-privacy'),
            onPressed: () => openExternalLink(
              context,
              PublicLinks.privacy(Localizations.localeOf(context)),
            ),
            child: Text(context.copy('auth.privacyLink')),
          ),
        ],
      ),
    ],
  );
}
