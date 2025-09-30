import 'package:get_it/get_it.dart';
import '../../../app/di/di_module.dart';
import '../../../shared/services/network_service.dart';
import '../data/datasources/resale_remote_datasource.dart';
import '../data/repositories/resale_repository_impl.dart';
import '../domain/repositories/resale_repository.dart';
import '../domain/usecases/get_resale_item_detail.dart';
import '../domain/usecases/get_resale_items.dart';
import '../domain/usecases/book_resale_item.dart';
import '../domain/usecases/cancel_book_resale_item.dart';
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
    getIt.registerFactory<BookResaleItemUseCase>(
      () => BookResaleItemUseCase(getIt<ResaleRepository>()),
    );
    getIt.registerFactory<CancelBookResaleItemUseCase>(
      () => CancelBookResaleItemUseCase(getIt<ResaleRepository>()),
    );

    // Blocs
    getIt.registerFactory<ResaleListBloc>(
      () => ResaleListBloc(
        getItems: getIt<GetResaleItemsUseCase>(),
        book: getIt<BookResaleItemUseCase>(),
        cancelBook: getIt<CancelBookResaleItemUseCase>(),
      ),
    );
    getIt.registerFactory<ResaleDetailBloc>(
      () => ResaleDetailBloc(
        getItemDetail: getIt<GetResaleItemDetailUseCase>(),
        book: getIt<BookResaleItemUseCase>(),
        cancelBook: getIt<CancelBookResaleItemUseCase>(),
      ),
    );
  }
}
