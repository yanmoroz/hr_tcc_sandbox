import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? backgroundColor;
  final Color? textColor;
  final bool outlined;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.outlined = false,
    this.borderColor,
    this.padding,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedTextColor = textColor ?? AppTheme.primaryColor;
    final Color resolvedBackgroundColor = backgroundColor ?? Colors.white;
    final Color resolvedBorderColor = borderColor ?? Colors.white;

    final EdgeInsetsGeometry resolvedPadding =
        padding ?? const EdgeInsets.symmetric(vertical: 16);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: resolvedBackgroundColor,
          foregroundColor: resolvedTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: resolvedBorderColor),
          ),
          padding: resolvedPadding,
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(resolvedTextColor),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
