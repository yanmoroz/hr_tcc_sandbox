import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class NetworkService {
  Future<http.Response> post(String url, Map<String, dynamic> body);
  Future<http.Response> get(String url);
  Future<http.Response> delete(String url);
}

class NetworkServiceImpl implements NetworkService {
  final http.Client _client;

  NetworkServiceImpl({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    return await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );
  }

  @override
  Future<http.Response> get(String url) async {
    return await _client.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
    );
  }

  @override
  Future<http.Response> delete(String url) async {
    return await _client.delete(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
    );
  }
}
