import 'package:get_it/get_it.dart';
import '../../../app/di/di_module.dart';
import '../../../shared/services/network_service.dart';
import '../data/datasources/news_remote_datasource.dart';
import '../data/repositories/news_repository_impl.dart';
import '../domain/repositories/news_repository.dart';
import '../domain/usecases/get_news.dart';
import '../domain/usecases/get_news_categories.dart';
import '../presentation/blocs/news_bloc.dart';

class NewsModule extends DiModule {
  @override
  void register(GetIt getIt) {
    getIt.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(getIt<NetworkService>()),
    );
    getIt.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(getIt<NewsRemoteDataSource>()),
    );
    getIt.registerLazySingleton<GetNewsUseCase>(
      () => GetNewsUseCase(getIt<NewsRepository>()),
    );
    getIt.registerLazySingleton<GetNewsCategoriesUseCase>(
      () => GetNewsCategoriesUseCase(getIt<NewsRepository>()),
    );
    getIt.registerFactory<NewsBloc>(
      () => NewsBloc(
        getNews: getIt<GetNewsUseCase>(),
        getCategories: getIt<GetNewsCategoriesUseCase>(),
      ),
    );
  }
}
