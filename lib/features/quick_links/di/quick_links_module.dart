import 'package:get_it/get_it.dart';

import '../../../app/di/di_module.dart';
import '../../../shared/services/url_launcher_service.dart';
import '../data/datasources/quick_links_local_datasource.dart';
import '../data/repositories/quick_links_repository_impl.dart';
import '../domain/repositories/quick_links_repository.dart';
import '../domain/usecases/get_quick_links.dart';
import '../domain/usecases/open_quick_link.dart';
import '../presentation/blocs/quick_links_bloc.dart';

class QuickLinksModule extends DiModule {
  @override
  void register(GetIt getIt) {
    getIt.registerLazySingleton<QuickLinksLocalDataSource>(
      () => QuickLinksLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<QuickLinksRepository>(
      () => QuickLinksRepositoryImpl(getIt<QuickLinksLocalDataSource>()),
    );
    getIt.registerLazySingleton<GetQuickLinksUseCase>(
      () => GetQuickLinksUseCase(getIt<QuickLinksRepository>()),
    );
    getIt.registerLazySingleton<OpenQuickLinkUseCase>(
      () => OpenQuickLinkUseCase(getIt<UrlLauncherService>()),
    );
    getIt.registerFactory<QuickLinksBloc>(
      () => QuickLinksBloc(
        getQuickLinks: getIt<GetQuickLinksUseCase>(),
        openQuickLink: getIt<OpenQuickLinkUseCase>(),
      ),
    );
  }
}
