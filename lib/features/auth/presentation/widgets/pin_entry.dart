import 'package:flutter/material.dart';

import 'pin_input.dart';
import 'numeric_keypad.dart';

class PinEntry extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int digitCount;
  final int maxDigits;
  final bool isLoading;
  final bool isError;
  final String? errorText;
  final double dotsSize;
  final Function(String) onDigitPressed;
  final VoidCallback? onDeletePressed;
  final bool showDeleteButton;
  final Widget? footer;

  const PinEntry({
    super.key,
    required this.title,
    this.subtitle,
    required this.digitCount,
    this.maxDigits = 4,
    this.isLoading = false,
    this.isError = false,
    this.errorText,
    this.dotsSize = 16,
    required this.onDigitPressed,
    this.onDeletePressed,
    this.showDeleteButton = true,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],

        const SizedBox(height: 60),

        // PIN dots + loading + error
        Column(
          children: [
            PinInput(
              digitCount: digitCount,
              maxDigits: maxDigits,
              size: dotsSize,
              isError: isError,
            ),
            if (isError && (errorText?.isNotEmpty ?? false)) ...[
              const SizedBox(height: 16),
              Text(
                errorText!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (isLoading) ...[
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
            ],
          ],
        ),

        const Spacer(),

        NumericKeypad(
          onDigitPressed: onDigitPressed,
          onDeletePressed: onDeletePressed,
          showDeleteButton: showDeleteButton,
        ),

        if (footer != null) ...[const SizedBox(height: 16), footer!],

        const SizedBox(height: 40),
      ],
    );
  }
}
