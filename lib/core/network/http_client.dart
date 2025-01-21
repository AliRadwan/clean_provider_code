import 'dart:convert';
import 'dart:io';
import 'package:clean_provider_code/core/network/http_error.dart';
import 'package:clean_provider_code/core/network/http_header.dart';
import 'package:http/http.dart' as http;



class HttpClient {
  final String baseUrl;
  final http.Client _client;

  HttpClient({
    required this.baseUrl,
  }) : _client = http.Client();

  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? queryParams}) async {
    try {
      final uri = Uri.parse(baseUrl + endpoint).replace(queryParameters: queryParams);
      final response = await _client.get(uri, headers: HttpHeader.instance.getHeaders());
      return _handleResponse(response);
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }


  dynamic _handleResponse(http.Response response, {bool? isBinary}) {
    switch (response.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.noContent:
      case HttpStatus.created:
        if (isBinary == true) {
          return response;
        }
        try {
          final bodyString = response.body.isEmpty ? '{}' : utf8.decode(response.bodyBytes);
          return json.decode(bodyString);
        } on FormatException catch (e) {
          throw NetworkException(
            message: 'Invalid JSON format: ${e.toString()}',
          );
        } catch (e) {
          throw NetworkException(
            message: 'Failed to decode response: ${e.toString()}',
          );
        }

      case HttpStatus.badRequest:
        throw NetworkException.badRequest();
      case HttpStatus.unauthorized:
      case HttpStatus.forbidden:
        throw NetworkException.unauthorized();
      case HttpStatus.notFound:
        throw NetworkException.notFound();
      case HttpStatus.requestTimeout:
        throw NetworkException.timeout();
      default:
        throw NetworkException(
          message: 'Server error: ${response.statusCode}',
          statusCode: response.statusCode,
        );
    }
  }

  void dispose() {
    _client.close();
  }
}
