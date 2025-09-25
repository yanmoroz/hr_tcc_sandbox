import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../shared/services/network_service.dart';
import '../../../../shared/services/secure_storage_service.dart';
import '../../../../shared/utils/auth_constants.dart';
import '../models/resale_models.dart';

abstract class ResaleRemoteDataSource {
  Future<List<ResaleListItemDto>> getItems({
    required int status,
    String? search,
    int page = 0,
    int pageSize = 20,
  });
  Future<ResaleDetailDto> getItemDetail(String id);
}

class ResaleRemoteDataSourceImpl implements ResaleRemoteDataSource {
  static const String _baseUrl =
      'https://dev-memp-hr-tcc-service.stoloto.su/api/v1';
  final NetworkService _network;
  final SecureStorageService _storage;

  ResaleRemoteDataSourceImpl(this._network, this._storage);

  Future<Map<String, String>> _authHeaders() async {
    final token = await _storage.getString(AuthConstants.accessTokenKey);
    return {
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<List<ResaleListItemDto>> getItems({
    required int status,
    String? search,
    int page = 0,
    int pageSize = 20,
  }) async {
    final headers = await _authHeaders();
    final query = <String, dynamic>{
      'status': status,
      if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      'page': page,
      'pageSize': pageSize,
    };

    final http.Response resp = await _network.get(
      '$_baseUrl/resell',
      headers: headers,
      query: query,
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('Failed to load resale items (${resp.statusCode})');
    }
    final decoded =
        jsonDecode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
    final items = (decoded['items'] as List<dynamic>? ?? const [])
        .map((e) => ResaleListItemDto.fromJson(e as Map<String, dynamic>))
        .toList();
    return items;
  }

  @override
  Future<ResaleDetailDto> getItemDetail(String id) async {
    final headers = await _authHeaders();
    final http.Response resp = await _network.get(
      '$_baseUrl/resell/$id',
      headers: headers,
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('Failed to load resale item ($id): ${resp.statusCode}');
    }
    final decoded =
        jsonDecode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
    return ResaleDetailDto.fromJson(decoded);
  }
}
