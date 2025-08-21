import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_quick_links.dart';
import '../../domain/usecases/open_quick_link.dart';
import 'quick_links_event.dart';
import 'quick_links_state.dart';

class QuickLinksBloc extends Bloc<QuickLinksEvent, QuickLinksState> {
  final GetQuickLinksUseCase _getQuickLinks;
  final OpenQuickLinkUseCase _openQuickLink;

  QuickLinksBloc({
    required GetQuickLinksUseCase getQuickLinks,
    required OpenQuickLinkUseCase openQuickLink,
  }) : _getQuickLinks = getQuickLinks,
       _openQuickLink = openQuickLink,
       super(const QuickLinksState()) {
    on<QuickLinksRequested>(_onRequested);
    on<QuickLinkOpened>(_onQuickLinkOpened);
  }

  Future<void> _onRequested(
    QuickLinksRequested event,
    Emitter<QuickLinksState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final links = await _getQuickLinks();
      emit(state.copyWith(isLoading: false, links: links));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onQuickLinkOpened(
    QuickLinkOpened event,
    Emitter<QuickLinksState> emit,
  ) async {
    try {
      await _openQuickLink(event.url);
    } catch (e) {
      // Handle error if needed, but don't emit new state for URL opening
      // as it's not a state-changing operation
    }
  }
}
