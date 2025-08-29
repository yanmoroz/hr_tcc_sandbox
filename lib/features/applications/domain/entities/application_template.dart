import 'package:flutter/material.dart';
import 'application_category.dart';
import 'application_type.dart';

class ApplicationTemplate {
  final String id;
  final String title;
  final ApplicationType type;
  final ApplicationCategory category;
  final IconData icon;

  const ApplicationTemplate({
    required this.id,
    required this.title,
    required this.type,
    required this.category,
    required this.icon,
  });
}
