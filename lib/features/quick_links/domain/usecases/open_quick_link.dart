import '../../../../shared/services/url_launcher_service.dart';

class OpenQuickLinkUseCase {
  final UrlLauncherService _urlLauncherService;

  OpenQuickLinkUseCase(this._urlLauncherService);

  Future<bool> call(String url) async {
    return await _urlLauncherService.openUrl(url);
  }
}
