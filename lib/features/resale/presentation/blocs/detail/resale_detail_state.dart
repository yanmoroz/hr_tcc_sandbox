import 'package:equatable/equatable.dart';
import '../../../domain/entities/resale_item.dart';

class ResaleDetailState extends Equatable {
  final ResaleItem? item;
  final bool isLoading;
  final String? error;

  const ResaleDetailState({this.item, this.isLoading = false, this.error});

  ResaleDetailState copyWith({
    ResaleItem? item,
    bool? isLoading,
    String? error,
  }) {
    return ResaleDetailState(
      item: item ?? this.item,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [item, isLoading, error];
}
