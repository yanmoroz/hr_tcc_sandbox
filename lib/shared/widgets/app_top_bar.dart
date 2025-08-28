import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;

  const AppTopBar({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black87,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed ?? () => context.pop(),
            )
          : null,
      title: _buildTitle(),
      actions: trailing != null ? [trailing!] : null,
      backgroundColor: backgroundColor,
      elevation: elevation,
      foregroundColor: foregroundColor,
      iconTheme: IconThemeData(color: foregroundColor),
    );
  }

  Widget? _buildTitle() {
    if (title == null && subtitle == null) {
      return null;
    }

    if (subtitle == null) {
      return Text(
        title!,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title!,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          subtitle!,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
