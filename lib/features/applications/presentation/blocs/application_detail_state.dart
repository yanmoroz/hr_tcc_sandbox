import '../../domain/entities/application.dart';

class ApplicationDetailState {
  final bool isLoading;
  final Application? application;
  final String? error;

  const ApplicationDetailState({
    this.isLoading = true,
    this.application,
    this.error,
  });

  ApplicationDetailState copyWith({
    bool? isLoading,
    Application? application,
    bool clearApplication = false,
    String? error,
  }) {
    return ApplicationDetailState(
      isLoading: isLoading ?? this.isLoading,
      application: clearApplication ? null : (application ?? this.application),
      error: error,
    );
  }
}
