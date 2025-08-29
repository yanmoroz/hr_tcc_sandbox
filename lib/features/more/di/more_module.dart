import 'package:get_it/get_it.dart';

import '../../../app/di/di_module.dart';
import '../../address_book/presentation/blocs/address_book_bloc.dart';
import '../../resale/presentation/blocs/resale_bloc.dart';
import '../../surveys/presentation/blocs/surveys_bloc.dart';
import '../presentation/blocs/more_bloc.dart';

class MoreModule extends DiModule {
  @override
  void register(GetIt getIt) {
    getIt.registerFactory<MoreBloc>(
      () => MoreBloc(
        resaleBloc: getIt<ResaleBloc>(),
        addressBookBloc: getIt<AddressBookBloc>(),
        surveysBloc: getIt<SurveysBloc>(),
      ),
    );
  }
}
