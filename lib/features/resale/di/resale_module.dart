import 'package:get_it/get_it.dart';
import '../../../app/di/di_module.dart';
import '../../../shared/services/network_service.dart';
import '../data/datasources/resale_remote_datasource.dart';
import '../data/repositories/resale_repository_impl.dart';
import '../domain/repositories/resale_repository.dart';
import '../domain/usecases/get_resale_item_detail.dart';
import '../domain/usecases/get_resale_items.dart';
import '../domain/usecases/toggle_booking.dart';
import '../presentation/blocs/list/resale_list_bloc.dart';
import '../presentation/blocs/detail/resale_detail_bloc.dart';

class ResaleModule extends DiModule {
  @override
  void register(GetIt getIt) {
    // Data sources
    getIt.registerLazySingleton<ResaleRemoteDataSource>(
      () => ResaleRemoteDataSourceImpl(getIt<NetworkService>()),
    );

    // Repository
    getIt.registerLazySingleton<ResaleRepository>(
      () => ResaleRepositoryImpl(getIt<ResaleRemoteDataSource>()),
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

    // Blocs
    getIt.registerFactory<ResaleListBloc>(
      () => ResaleListBloc(
        getItems: getIt<GetResaleItemsUseCase>(),
        toggleBooking: getIt<ToggleBookingUseCase>(),
      ),
    );
    getIt.registerFactory<ResaleDetailBloc>(
      () => ResaleDetailBloc(
        getItemDetail: getIt<GetResaleItemDetailUseCase>(),
        toggleBooking: getIt<ToggleBookingUseCase>(),
      ),
    );
  }
}
