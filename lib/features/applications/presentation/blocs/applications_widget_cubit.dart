import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/application.dart';
import '../../domain/entities/application_template.dart';
import '../../domain/entities/application_type.dart';
import '../../domain/usecases/get_application_templates.dart';
import '../../domain/usecases/get_applications.dart';

class ApplicationsWidgetState {
  final bool isLoading;
  final List<ApplicationsWidgetItem> items;

  const ApplicationsWidgetState({
    this.isLoading = false,
    this.items = const [],
  });

  ApplicationsWidgetState copyWith({
    bool? isLoading,
    List<ApplicationsWidgetItem>? items,
  }) {
    return ApplicationsWidgetState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
    );
  }
}

class ApplicationsWidgetItem {
  final ApplicationType type;
  final String title;
  final IconData icon;
  final String applicationId;

  const ApplicationsWidgetItem({
    required this.type,
    required this.title,
    required this.icon,
    required this.applicationId,
  });
}

class ApplicationsWidgetCubit extends Cubit<ApplicationsWidgetState> {
  final GetApplicationsUseCase _getApplications;
  final GetApplicationTemplatesUseCase _getTemplates;

  ApplicationsWidgetCubit({
    required GetApplicationsUseCase getApplications,
    required GetApplicationTemplatesUseCase getTemplates,
  }) : _getApplications = getApplications,
       _getTemplates = getTemplates,
       super(const ApplicationsWidgetState());

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));

    final List<Application> apps = await _getApplications();
    final List<ApplicationTemplate> templates = await _getTemplates();

    final Set<ApplicationType> inProgressTypes = apps
        .where((a) => a.status == ApplicationStatus.inProgress)
        .map((a) => a.type)
        .toSet();

    final List<ApplicationsWidgetItem> items = templates
        .where((t) => inProgressTypes.contains(t.type))
        .map(
          (t) => ApplicationsWidgetItem(
            type: t.type,
            title: t.type.displayName,
            icon: t.icon,
            applicationId: apps.firstWhere((a) => a.type == t.type).id,
          ),
        )
        .toList()
        .take(3)
        .toList();

    emit(state.copyWith(isLoading: false, items: items));
  }
}
