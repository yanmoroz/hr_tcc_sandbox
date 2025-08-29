import 'package:get_it/get_it.dart';

import '../../../app/di/di_module.dart';
import '../../address_book/domain/usecases/get_contacts.dart';
import '../../resale/domain/usecases/get_resale_items.dart';
import '../../surveys/domain/usecases/get_surveys.dart';
import '../presentation/blocs/more_bloc.dart';

class MoreModule extends DiModule {
  @override
  void register(GetIt getIt) {
    getIt.registerFactory<MoreBloc>(
      () => MoreBloc(
        getResaleItems: getIt<GetResaleItemsUseCase>(),
        getContacts: getIt<GetContacts>(),
        getSurveys: getIt<GetSurveysUseCase>(),
      ),
    );
  }
}
