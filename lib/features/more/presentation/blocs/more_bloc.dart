import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../address_book/presentation/blocs/address_book_bloc.dart';
import '../../../address_book/presentation/blocs/address_book_event.dart';
import '../../../address_book/presentation/blocs/address_book_state.dart';
import '../../../resale/presentation/blocs/resale_bloc.dart';
import '../../../resale/presentation/blocs/resale_event.dart';
import '../../../resale/presentation/blocs/resale_state.dart';
import '../../../surveys/presentation/blocs/surveys_bloc.dart';
import '../../../surveys/domain/entities/survey.dart';
import '../../../surveys/presentation/blocs/surveys_event.dart';
import '../../../surveys/presentation/blocs/surveys_state.dart';
import 'more_event.dart';
import 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final ResaleBloc resaleBloc;
  final AddressBookBloc addressBookBloc;
  final SurveysBloc surveysBloc;

  late final Stream<dynamic> _resaleSubscription;
  late final Stream<dynamic> _addressSubscription;
  late final Stream<dynamic> _surveysSubscription;

  MoreBloc({
    required this.resaleBloc,
    required this.addressBookBloc,
    required this.surveysBloc,
  }) : super(const MoreState()) {
    on<MoreRequested>(_onRequested);

    // Listen to children blocs and update aggregated counts
    _resaleSubscription = resaleBloc.stream;
    _addressSubscription = addressBookBloc.stream;
    _surveysSubscription = surveysBloc.stream;

    _resaleSubscription.listen((event) {
      if (event is ResaleState) {
        add(const MoreRequested());
      }
    });
    _addressSubscription.listen((event) {
      if (event is AddressBookState) {
        add(const MoreRequested());
      }
    });
    _surveysSubscription.listen((event) {
      if (event is SurveysState) {
        add(const MoreRequested());
      }
    });
  }

  void _onRequested(MoreRequested event, Emitter<MoreState> emit) {
    // Ensure child blocs have data loaded
    final resaleState = resaleBloc.state;
    if (!resaleState.isLoading && resaleState.allItems.isEmpty) {
      resaleBloc.add(ResaleRequested());
    }

    final abState = addressBookBloc.state;
    if (abState is! AddressBookLoaded) {
      addressBookBloc.add(const LoadContacts());
    }

    final surveysStateCurrent = surveysBloc.state;
    if (!surveysStateCurrent.isLoading &&
        surveysStateCurrent.allSurveys.isEmpty) {
      surveysBloc.add(SurveysRequested());
    }

    // Aggregate values
    final resaleTotal = resaleBloc.state.allItems.length;

    int contactsTotal = 0;
    final addressState = addressBookBloc.state;
    if (addressState is AddressBookLoaded) {
      contactsTotal = addressState.totalCount;
    }

    final surveysState = surveysBloc.state;
    final int notCompleted = surveysState.allSurveys
        .where((s) => s.status == SurveyStatus.notCompleted)
        .length;

    emit(
      state.copyWith(
        resaleItemsTotal: resaleTotal,
        contactsTotal: contactsTotal,
        surveysNotCompletedTotal: notCompleted,
      ),
    );
  }

  @override
  Future<void> close() {
    // Child blocs are owned by DI; just cancel stream subscriptions if needed
    return super.close();
  }
}
