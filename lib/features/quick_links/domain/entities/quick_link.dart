class QuickLink {
  final String id;
  final String title;
  final String? subtitle;
  final String url;
  final String pageIconAsset;
  final String widgetIconAsset;
  final int accentColor;

  const QuickLink({
    required this.id,
    required this.title,
    this.subtitle,
    required this.url,
    required this.pageIconAsset,
    required this.widgetIconAsset,
    required this.accentColor,
  });
}
