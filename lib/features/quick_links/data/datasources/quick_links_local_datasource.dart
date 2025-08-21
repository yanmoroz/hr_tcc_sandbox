import '../../../../gen/assets.gen.dart';
import '../../domain/entities/quick_link.dart';

abstract class QuickLinksLocalDataSource {
  Future<List<QuickLink>> getQuickLinks();
}

class QuickLinksLocalDataSourceImpl implements QuickLinksLocalDataSource {
  @override
  Future<List<QuickLink>> getQuickLinks() async {
    // Static seed for now
    return [
      QuickLink(
        id: 'telegram',
        title: 'Telegram',
        subtitle: 'Телеграм-канал S8',
        url: 'https://t.me/',
        pageIconAsset: Assets.icons.quickLinks.page.telegram,
        widgetIconAsset: Assets.icons.quickLinks.widget.telegram,
        accentColor: 0xFF2BA3EC,
      ),
      QuickLink(
        id: 'ispring',
        title: 'Ispring',
        subtitle: 'Дистанционное обучение организаций',
        url: 'https://www.ispring.ru/',
        pageIconAsset: Assets.icons.quickLinks.page.ispring,
        widgetIconAsset: Assets.icons.quickLinks.widget.ispring,
        accentColor: 0xFF31BF71,
      ),
      QuickLink(
        id: 'potok',
        title: 'Potok',
        subtitle: 'Автоматизация рекрутмента',
        url: 'https://potok.digital/',
        pageIconAsset: Assets.icons.quickLinks.page.potok,
        widgetIconAsset: Assets.icons.quickLinks.widget.potok,
        accentColor: 0xFF1C72FF,
      ),
      QuickLink(
        id: 'confluence',
        title: 'Confluence',
        subtitle: 'Совместная работа с документами',
        url: 'https://www.atlassian.com/software/confluence',
        pageIconAsset: Assets.icons.quickLinks.page.confluence,
        widgetIconAsset: Assets.icons.quickLinks.widget.confluence,
        accentColor: 0xFF1C72FF,
      ),
      QuickLink(
        id: 'jira',
        title: 'Jira',
        subtitle: 'Диспетчер задач (управление проектами)',
        url: 'https://www.atlassian.com/software/jira',
        pageIconAsset: Assets.icons.quickLinks.page.jira,
        widgetIconAsset: Assets.icons.quickLinks.widget.jira,
        accentColor: 0xFF1C72FF,
      ),
    ];
  }
}
