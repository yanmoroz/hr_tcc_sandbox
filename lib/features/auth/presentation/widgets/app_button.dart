import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class AppButton extends StatelessWidget {
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
  final Widget? leading;
  final Widget? trailing;
  final double? height;

  const AppButton({
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
    this.leading,
    this.trailing,
    this.height,
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
      height: height,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: resolvedBackgroundColor,
          foregroundColor: resolvedTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: outlined || borderColor != null
                ? BorderSide(color: resolvedBorderColor)
                : BorderSide.none,
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
            : _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (leading != null || trailing != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 8)],
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      );
    } else {
      return Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      );
    }
  }
}
