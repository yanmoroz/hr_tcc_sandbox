class NewsItem {
  final String id;
  final String title;
  final String subtitle;
  final String? imageAsset;
  final String categoryId;
  final DateTime publishedAt;
  final String? body;

  const NewsItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.categoryId,
    required this.publishedAt,
    this.imageAsset,
    this.body,
  });
}

class NewsCategory {
  final String id;
  final String title;

  const NewsCategory({required this.id, required this.title});
}
