import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/password_policy.dart';

void main() {
  final cases = <(String, String?, PasswordLengthIssue?)>[
    ('missing', null, PasswordLengthIssue.tooShort),
    ('empty', '', PasswordLengthIssue.tooShort),
    ('ASCII 7 bytes', 'a' * 7, PasswordLengthIssue.tooShort),
    ('ASCII 8 bytes', 'a' * 8, null),
    ('ASCII 72 bytes', 'a' * 72, null),
    ('ASCII 73 bytes', 'a' * 73, PasswordLengthIssue.tooLong),
    ('accented 6 bytes', 'é' * 3, PasswordLengthIssue.tooShort),
    ('accented 8 bytes', 'é' * 4, null),
    ('accented 72 bytes', 'é' * 36, null),
    ('accented 74 bytes', 'é' * 37, PasswordLengthIssue.tooLong),
    ('combining 7 bytes', '${'e\u0301' * 2}a', PasswordLengthIssue.tooShort),
    ('combining 8 bytes', '${'e\u0301' * 2}aa', null),
    ('combining 72 bytes', 'e\u0301' * 24, null),
    ('combining 73 bytes', '${'e\u0301' * 24}a', PasswordLengthIssue.tooLong),
    ('emoji 7 bytes', '🚀aaa', PasswordLengthIssue.tooShort),
    ('emoji 8 bytes', '🚀' * 2, null),
    ('emoji 72 bytes', '🚀' * 18, null),
    ('emoji 73 bytes', '${'🚀' * 18}a', PasswordLengthIssue.tooLong),
  ];
  for (final (description, value, issue) in cases) {
    test(description, () {
      expect(validatePasswordLength(value), issue);
    });
  }

  test('canonically equivalent passwords keep their original byte lengths', () {
    expect(validatePasswordLength('é' * 25), isNull);
    expect(validatePasswordLength('e\u0301' * 25), PasswordLengthIssue.tooLong);
  });

  test('spaces remain part of the password', () {
    expect(validatePasswordLength(' aaaaaa '), isNull);
  });
}
