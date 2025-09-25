import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'logger_service.dart';
import 'auth_header_provider.dart';

abstract class NetworkService {
  Future<http.Response> post(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });
  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });
  Future<http.Response> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });
}

class NetworkServiceImpl implements NetworkService {
  final http.Client _client;
  final LoggerService _logger = LoggerService();
  final AuthHeaderProvider? _authHeaderProvider;

  NetworkServiceImpl({
    http.Client? client,
    AuthHeaderProvider? authHeaderProvider,
  }) : _client = client ?? _createDefaultClient(),
       _authHeaderProvider = authHeaderProvider;

  static http.Client _createDefaultClient() {
    if (kIsWeb) {
      return http.Client();
    }
    final HttpClient ioHttpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return IOClient(ioHttpClient);
  }

  Uri _buildUri(String url, Map<String, dynamic>? query) {
    final uri = Uri.parse(url);
    if (query == null || query.isEmpty) return uri;
    final merged = Map<String, dynamic>.from(uri.queryParameters)
      ..addAll(query.map((k, v) => MapEntry(k, v?.toString() ?? '')));
    return uri.replace(queryParameters: merged);
  }

  Future<Map<String, String>> _mergeHeaders(
    Map<String, String>? headers,
  ) async {
    final authHeaders = _authHeaderProvider != null
        ? await _authHeaderProvider.getHeaders()
        : const <String, String>{};
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...authHeaders,
      if (headers != null) ...headers,
    };
  }

  @override
  Future<http.Response> post(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = _buildUri(url, query);
    final mergedHeaders = await _mergeHeaders(headers);
    _logger.info('HTTP POST ${uri.toString()}');
    _logger.debug('Headers: $mergedHeaders');
    _logger.debug('Body: ${jsonEncode(body)}');
    final response = await _client.post(
      uri,
      headers: mergedHeaders,
      body: jsonEncode(body),
    );
    _logResponse('POST', uri, response);
    return response;
  }

  @override
  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = _buildUri(url, query);
    final mergedHeaders = await _mergeHeaders(headers);
    _logger.info('HTTP GET ${uri.toString()}');
    _logger.debug('Headers: $mergedHeaders');
    final response = await _client.get(uri, headers: mergedHeaders);
    _logResponse('GET', uri, response);
    return response;
  }

  @override
  Future<http.Response> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = _buildUri(url, query);
    final mergedHeaders = await _mergeHeaders(headers);
    _logger.info('HTTP DELETE ${uri.toString()}');
    _logger.debug('Headers: $mergedHeaders');
    final response = await _client.delete(uri, headers: mergedHeaders);
    _logResponse('DELETE', uri, response);
    return response;
  }

  void _logResponse(String method, Uri uri, http.Response response) {
    final preview = _previewBody(response.bodyBytes);
    _logger.info('HTTP ${response.statusCode} $method ${uri.toString()}');
    if (preview.isNotEmpty) {
      _logger.debug('Response: $preview');
    }
  }

  String _previewBody(List<int> bodyBytes, {int maxLength = 800}) {
    try {
      final text = utf8.decode(bodyBytes);
      if (text.length <= maxLength) return text;
      return text.substring(0, maxLength) + '...';
    } catch (_) {
      return '';
    }
  }
}
