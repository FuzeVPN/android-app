import 'dart:convert';

/// The API measures the original password in UTF-8 bytes, not characters.
/// Keep the value unchanged so normalization cannot alter a user's password.
enum PasswordLengthIssue { tooShort, tooLong }

PasswordLengthIssue? validatePasswordLength(String? password) {
  final int byteLength = utf8.encode(password ?? '').length;
  if (byteLength < 8) return PasswordLengthIssue.tooShort;
  if (byteLength > 72) return PasswordLengthIssue.tooLong;
  return null;
}
