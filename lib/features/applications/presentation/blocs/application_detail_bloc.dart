import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_application.dart';
import 'application_detail_event.dart';
import 'application_detail_state.dart';

class ApplicationDetailBloc
    extends Bloc<ApplicationDetailEvent, ApplicationDetailState> {
  final GetApplicationUseCase _getApplication;

  ApplicationDetailBloc({required GetApplicationUseCase getApplication})
    : _getApplication = getApplication,
      super(const ApplicationDetailState()) {
    on<ApplicationDetailStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ApplicationDetailStarted event,
    Emitter<ApplicationDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearApplication: true));
    final app = await _getApplication(event.id);
    if (app == null) {
      emit(state.copyWith(isLoading: false, error: 'Заявка не найдена'));
    } else {
      emit(state.copyWith(isLoading: false, application: app));
    }
  }
}
