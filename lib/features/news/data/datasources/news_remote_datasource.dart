import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../shared/services/network_service.dart';
import '../models/news_models.dart';

abstract class NewsRemoteDataSource {
  Future<NewsListResponseDto> getNews({int? category, int page = 0});
  Future<List<NewsCategoryDto>> getCategories();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  static const String _baseUrl =
      'https://dev-memp-hr-tcc-service.stoloto.su/api/v1';
  final NetworkService _network;

  NewsRemoteDataSourceImpl(this._network);

  @override
  Future<NewsListResponseDto> getNews({int? category, int page = 0}) async {
    final query = <String, dynamic>{
      'page': page,
      if (category != null) 'category': category,
    };

    final http.Response resp = await _network.get(
      '$_baseUrl/news',
      query: query,
    );

    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('Failed to load news (${resp.statusCode})');
    }

    try {
      final decoded =
          jsonDecode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
      return NewsListResponseDto.fromJson(decoded);
    } catch (e, _) {
      rethrow;
    }
  }

  @override
  Future<List<NewsCategoryDto>> getCategories() async {
    final http.Response resp = await _network.get(
      '$_baseUrl/dictionaries/news-category',
    );

    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('Failed to load news categories (${resp.statusCode})');
    }

    final decoded =
        jsonDecode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
    final list = decoded['newsCategories'] as List<dynamic>? ?? const [];
    final categories = list
        .map((e) => NewsCategoryDto.fromJson(e as Map<String, dynamic>))
        .toList();
    return categories;
  }
}
