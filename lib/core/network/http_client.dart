import 'dart:convert';

import 'package:clean_provider_code/core/network/http_config.dart';
import 'package:clean_provider_code/core/network/http_error.dart';
import 'package:clean_provider_code/core/network/http_response.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final HttpConfig config;
  // final String baseUrl;
  // final Map<String, String> defaultHeaders;
  final http.Client _client;

  HttpClient({required this.config}) : _client = http.Client();

 Map<String, String> _mergeHeaders(Map<String, String>? headers) => {...config.defaultHeaders,...?headers};

 Uri _buildUri (String endpoint,{Map<String, String>? queryParams}) {
   final uri = Uri.parse(config.baseUrl+endpoint);
   if(queryParams != null){
     return uri.replace(queryParameters: queryParams.map((key, value)=>MapEntry(key, value.toString())));
   }
   return uri;
 }


  Future<HttpResponse<T>> _handleResponse<T>(
      http.Response response,
      T Function(Map<String, dynamic>) converter,
      ) async {
    try {
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return HttpResponse<T>(
          data: converter(jsonData),
          statusCode: statusCode,
          headers: response.headers,
        );
      } else {
        throw HttpError(
          message: 'Request failed with status: $statusCode',
          statusCode: statusCode,
          data: _tryDecodeError(response.body),
        );
      }
    } catch (e) {
      if (e is HttpError) rethrow;
      throw HttpError(
        message: 'Failed to process response: ${e.toString()}',
        statusCode: response.statusCode,
      );
    }
  }

  dynamic _tryDecodeError(String body) {
    try {
      return json.decode(body);
    } catch (_) {
      return body;
    }
  }

  Future<HttpResponse<T>> get<T>(
      String endpoint, {
        Map<String, dynamic>? queryParams,
        Map<String, String>? headers,
        required T Function(Map<String, dynamic>) converter,
      }) async {
    try {
      final response = await _client
          .get(
        _buildUri(endpoint, queryParams:queryParams),
        headers: _mergeHeaders(headers),
      )
          .timeout(config.timeout);

      return _handleResponse(response, converter);
    } catch (e) {
      if (e is HttpError) rethrow;
      throw HttpError(message: e.toString());
    }
  }


  Future<Map<String,dynamic>> get(String endpoint,{Map<String, String>? queryParams,
    Map<String, String>? headers,}) async {
    try{
      final url = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final response =  await _client.get(url,headers:{...defaultHeaders,...?headers} );

    return _handleResponse(response);
    }catch(e){
      throw HttpError(message: e.toString());
    }

  }


  Map<String,dynamic> _handleResponse(http.Response response){
    if(response.statusCode == 200 && response.statusCode <300){
      try{
      return  json.decode(response.body);
      }catch(e){
        throw HttpError(message: 'Failed to decode response: ${response.body}',
          statusCode: response.statusCode,);
      }
    }else {
      throw HttpError(message: response.body,statusCode: response.statusCode,);
    }

  }

  void dispose() {
    _client.close();
  }
}



