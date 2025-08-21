import 'package:equatable/equatable.dart';

abstract class QuickLinksEvent extends Equatable {
  const QuickLinksEvent();
  @override
  List<Object?> get props => [];
}

class QuickLinksRequested extends QuickLinksEvent {}

class QuickLinkOpened extends QuickLinksEvent {
  final String url;

  const QuickLinkOpened(this.url);

  @override
  List<Object?> get props => [url];
}
