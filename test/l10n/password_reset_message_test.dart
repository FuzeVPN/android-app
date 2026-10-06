import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

void main() {
  final cases = <(String, String, String, String)>[
    ('fr', 'reçue', 'pourra', 'vient d’être envoyé'),
    ('en', 'received', 'may', 'has just been sent'),
    ('de', 'erhalten', 'möglicherweise', 'wurde soeben'),
    ('es', 'recibida', 'es posible', 'se acaba de enviar'),
  ];
  for (final (language, received, conditional, oldPromise) in cases) {
    test(
      '$language reset notice acknowledges the request without promising an email',
      () async {
        final copy = await AppLocalizations.delegate.load(Locale(language));
        final title = copy.notice_controller_title('password_reset_sent');
        final message = copy.notice_controller_message(
          'password_reset_sent',
          '',
        );
        expect(title, contains(received));
        expect(message, contains(conditional));
        expect(message, isNot(contains(oldPromise)));
      },
    );
  }
}
