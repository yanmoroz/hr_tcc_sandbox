import 'package:equatable/equatable.dart';

class MoreState extends Equatable {
  final int resaleItemsTotal;
  final int contactsTotal;
  final int surveysNotCompletedTotal;
  final bool isLoading;
  final String? error;

  const MoreState({
    this.resaleItemsTotal = 0,
    this.contactsTotal = 0,
    this.surveysNotCompletedTotal = 0,
    this.isLoading = false,
    this.error,
  });

  MoreState copyWith({
    int? resaleItemsTotal,
    int? contactsTotal,
    int? surveysNotCompletedTotal,
    bool? isLoading,
    String? error,
  }) {
    return MoreState(
      resaleItemsTotal: resaleItemsTotal ?? this.resaleItemsTotal,
      contactsTotal: contactsTotal ?? this.contactsTotal,
      surveysNotCompletedTotal:
          surveysNotCompletedTotal ?? this.surveysNotCompletedTotal,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    resaleItemsTotal,
    contactsTotal,
    surveysNotCompletedTotal,
    isLoading,
    error,
  ];
}
