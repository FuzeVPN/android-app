import 'package:flutter/material.dart';

/// Keep the full correction instructions visible at the user's text scale.
Widget buildValidationError(BuildContext context, String message) => Text(
  message,
  style: Theme.of(
    context,
  ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error),
);
