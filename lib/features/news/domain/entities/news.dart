class NewsItem {
  final String id;
  final String title;
  final String subtitle;
  final String? imageAsset;
  final String categoryId;
  final DateTime publishedAt;
  final String? body;
  final bool published;
  final int priority;
  final String? authorName;
  final int likeCount;
  final bool like;
  final int commentCount;

  const NewsItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.categoryId,
    required this.publishedAt,
    this.imageAsset,
    this.body,
    this.published = true,
    this.priority = 0,
    this.authorName,
    this.likeCount = 0,
    this.like = false,
    this.commentCount = 0,
  });
}

class NewsCategory {
  final String id;
  final String title;

  const NewsCategory({required this.id, required this.title});
}

class NewsListResult {
  final List<NewsItem> items;
  final int total;
  final int currentPage;
  final bool hasMore;

  const NewsListResult({
    required this.items,
    required this.total,
    required this.currentPage,
    required this.hasMore,
  });
}
