import 'package:equatable/equatable.dart';
import '../../domain/entities/quick_link.dart';

class QuickLinksState extends Equatable {
  final List<QuickLink> links;
  final bool isLoading;
  final String? error;

  const QuickLinksState({
    this.links = const [],
    this.isLoading = false,
    this.error,
  });

  QuickLinksState copyWith({
    List<QuickLink>? links,
    bool? isLoading,
    String? error,
  }) {
    return QuickLinksState(
      links: links ?? this.links,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [links, isLoading, error];
}
