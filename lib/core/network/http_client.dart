import 'dart:convert';

import 'package:clean_provider_code/core/network/network_exception.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl;
  final Map<String, String> defaultHeaders;
  final http.Client _client;

  HttpClient({required this.baseUrl, this.defaultHeaders = const {'Content-Type': 'application/json'}}) : _client = http.Client();


  Future<Map<String,dynamic>> get(String endpoint,{Map<String, String>? queryParams,
    Map<String, String>? headers,}) async {
    try{
      final url = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final response =  await _client.get(url,headers:{...defaultHeaders,...?headers} );

    return _handleResponse(response);
    }catch(e){
      throw NetworkException(message: e.toString());
    }

  }


  Map<String,dynamic> _handleResponse(http.Response response){
    if(response.statusCode == 200 && response.statusCode <300){
      try{
      return  json.decode(response.body);
      }catch(e){
        throw NetworkException(message: 'Failed to decode response: ${response.body}',
          statusCode: response.statusCode,);
      }
    }else {
      throw NetworkException(message: response.body,statusCode: response.statusCode,);
    }

  }

  void dispose() {
    _client.close();
  }
}



