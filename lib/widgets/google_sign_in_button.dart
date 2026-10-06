import 'package:flutter/material.dart';

import '../l10n/app_copy.dart';

/// Public Google branding assets are rendered unchanged; Fuze styles surround
/// this provider control rather than tinting its logo or changing its typeface.
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: dark ? const Color(0xFF131314) : Colors.white,
        foregroundColor: dark
            ? const Color(0xFFE3E3E3)
            : const Color(0xFF1F1F1F),
        side: BorderSide(
          color: dark ? const Color(0xFF8E918F) : const Color(0xFF747775),
        ),
        minimumSize: const Size.fromHeight(48),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: const TextStyle(
          fontFamily: 'Google Sans',
          fontFamilyFallback: ['Noto Sans Arabic'],
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: Row(
        children: [
          ExcludeSemantics(
            child: Image.asset(
              'assets/images/google-g.png',
              width: 20,
              height: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.copy('google.continue'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class GoogleAuthMethodsDivider extends StatelessWidget {
  const GoogleAuthMethodsDivider({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 18),
    child: Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            context.copy('google.or'),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const Expanded(child: Divider()),
      ],
    ),
  );
}
