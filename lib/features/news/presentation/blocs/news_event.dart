import 'package:equatable/equatable.dart';

class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsStarted extends NewsEvent {}

class NewsLoadMore extends NewsEvent {}

class NewsRefresh extends NewsEvent {}

class NewsSearchChanged extends NewsEvent {
  final String query;
  NewsSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class NewsCategoryChanged extends NewsEvent {
  final String categoryId;
  NewsCategoryChanged(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
