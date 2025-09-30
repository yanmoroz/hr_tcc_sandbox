import '../../domain/entities/news.dart';

class NewsCategoryDto {
  final int code;
  final String name;

  NewsCategoryDto({required this.code, required this.name});

  factory NewsCategoryDto.fromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey('code')) {
        throw FormatException('Missing required field: code');
      }
      if (!json.containsKey('name')) {
        throw FormatException('Missing required field: name');
      }

      return NewsCategoryDto(
        code: json['code'] as int,
        name: json['name'] as String,
      );
    } catch (e, _) {
      rethrow;
    }
  }

  NewsCategory toEntity() {
    return NewsCategory(id: code.toString(), title: name);
  }
}

class NewsAuthorDto {
  final String firstName;
  final String lastName;
  final String middleName;
  final String photo;
  final int id;
  final String title;

  NewsAuthorDto({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.photo,
    required this.id,
    required this.title,
  });

  factory NewsAuthorDto.fromJson(Map<String, dynamic> json) {
    try {
      final requiredFields = [
        'firstName',
        'lastName',
        'middleName',
        'photo',
        'id',
        'title',
      ];
      for (final field in requiredFields) {
        if (!json.containsKey(field)) {
          throw FormatException('Missing required field: $field');
        }
      }

      return NewsAuthorDto(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        middleName: json['middleName'] as String,
        photo: json['photo'] as String,
        id: json['id'] as int,
        title: json['title'] as String,
      );
    } catch (e, _) {
      rethrow;
    }
  }

  String get fullName {
    final parts = [
      firstName,
      middleName,
      lastName,
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' ');
  }
}

class NewsItemDto {
  final int id;
  final String title;
  final String? summary;
  final String createdData;
  final bool published;
  final int priority;
  final String? image;
  final NewsCategoryDto? category;
  final NewsAuthorDto author;
  final int likeCount;
  final bool like;
  final int commentCount;

  NewsItemDto({
    required this.id,
    required this.title,
    this.summary,
    required this.createdData,
    required this.published,
    required this.priority,
    this.image,
    this.category,
    required this.author,
    required this.likeCount,
    required this.like,
    required this.commentCount,
  });

  factory NewsItemDto.fromJson(Map<String, dynamic> json) {
    try {
      return NewsItemDto(
        id: json['id'] as int,
        title: json['title'] as String,
        summary: json['summary'] as String?,
        createdData: json['createdData'] as String,
        published: json['published'] as bool,
        priority: (json['priority'] as num).toInt(),
        image: json['image'] as String?,
        category: json['category'] != null
            ? NewsCategoryDto.fromJson(json['category'] as Map<String, dynamic>)
            : null,
        author: NewsAuthorDto.fromJson(json['author'] as Map<String, dynamic>),
        likeCount: json['likeCount'] as int,
        like: json['like'] as bool,
        commentCount: json['commentCount'] as int,
      );
    } catch (e, _) {
      rethrow;
    }
  }

  NewsItem toEntity() {
    return NewsItem(
      id: id.toString(),
      title: title,
      subtitle: summary ?? '',
      categoryId: category?.code.toString() ?? '0',
      publishedAt: DateTime.tryParse(createdData) ?? DateTime.now(),
      imageAsset: image?.isNotEmpty == true ? image : null,
      body: null, // Not provided in list API
      published: published,
      priority: priority,
      authorName: author.fullName,
      likeCount: likeCount,
      like: like,
      commentCount: commentCount,
    );
  }
}

class NewsListResponseDto {
  final List<NewsItemDto> items;
  final int total;

  NewsListResponseDto({required this.items, required this.total});

  factory NewsListResponseDto.fromJson(Map<String, dynamic> json) {
    try {
      // Validate required fields first
      if (!json.containsKey('items')) {
        throw FormatException('Missing required field: items');
      }
      if (!json.containsKey('total')) {
        throw FormatException('Missing required field: total');
      }

      final itemsList = json['items'] as List<dynamic>;
      final items = <NewsItemDto>[];

      // Parse items with detailed error tracking
      for (int i = 0; i < itemsList.length; i++) {
        try {
          final itemJson = itemsList[i] as Map<String, dynamic>;
          final item = NewsItemDto.fromJson(itemJson);
          items.add(item);
        } catch (e, _) {
          rethrow;
        }
      }

      return NewsListResponseDto(items: items, total: json['total'] as int);
    } catch (e, _) {
      rethrow;
    }
  }
}
