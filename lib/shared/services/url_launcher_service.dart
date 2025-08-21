import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncherService {
  Future<bool> openUrl(String url);
}

class UrlLauncherServiceImpl implements UrlLauncherService {
  @override
  Future<bool> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }
}
