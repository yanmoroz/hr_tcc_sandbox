import 'package:get_it/get_it.dart';
import '../../../app/di/di_module.dart';
import '../data/datasources/resale_local_datasource.dart';
import '../data/repositories/resale_repository_impl.dart';
import '../domain/repositories/resale_repository.dart';
import '../domain/usecases/get_resale_item_detail.dart';
import '../domain/usecases/get_resale_items.dart';
import '../domain/usecases/toggle_booking.dart';
import '../presentation/blocs/resale_bloc.dart';

class ResaleModule extends DiModule {
  @override
  void register(GetIt getIt) {
    // Data sources
    getIt.registerLazySingleton<ResaleLocalDataSource>(
      () => ResaleLocalDataSourceImpl(),
    );

    // Repository
    getIt.registerLazySingleton<ResaleRepository>(
      () => ResaleRepositoryImpl(getIt<ResaleLocalDataSource>()),
    );

    // Use cases
    getIt.registerFactory<GetResaleItemsUseCase>(
      () => GetResaleItemsUseCase(getIt<ResaleRepository>()),
    );
    getIt.registerFactory<GetResaleItemDetailUseCase>(
      () => GetResaleItemDetailUseCase(getIt<ResaleRepository>()),
    );
    getIt.registerFactory<ToggleBookingUseCase>(
      () => ToggleBookingUseCase(getIt<ResaleRepository>()),
    );

    // Bloc
    getIt.registerFactory<ResaleBloc>(
      () => ResaleBloc(
        getItems: getIt<GetResaleItemsUseCase>(),
        toggleBooking: getIt<ToggleBookingUseCase>(),
      ),
    );
  }
}
