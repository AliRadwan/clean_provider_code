import 'package:clean_provider_code/core/network/http_client.dart';
import 'package:clean_provider_code/core/network/http_config.dart';
import 'package:clean_provider_code/core/network/http_error.dart';
import 'package:clean_provider_code/feature/data/weather_api_service.dart';
import 'package:clean_provider_code/feature/model/weather_model.dart';

class WeatherApiServiceImpl  implements WeatherApiService {
  final HttpClient _httpClient;
  final String apiKey;

  WeatherApiServiceImpl({required this.apiKey}) : _httpClient = HttpClient(
    baseUrl: 'https://api.openweathermap.org/data/2.5',
  );


  @override
  Future<WeatherModel> getWeatherByCity(String city) async {
    try {
      final response = await _httpClient.get(
        '/weather',
        queryParams: {
          'q': city,
          'units': 'metric',
          'appid': apiKey,
        },headers: HttpHeader(authorization: '').getHeaders(requireAuth: true),
      );

      return WeatherModel.fromJson(response);
    } on NetworkException catch (e) {
      throw Exception('Failed to get weather data: ${e.message}');
    }
  }
  
  //
  // @override
  // Future <WeatherModel> getWeatherByCity(String cityName) async {
  //   try{
  //     final response =  await _httpClient.get('/weather',queryParams: {
  //       'q': cityName,
  //       'units': 'metric',
  //       'appid': apiKey
  //     }, converter: (json)=>  WeatherModel.fromJson(json));
  //     // return WeatherModel.fromJson(response);
  //     return response.data;
  //   } on HttpError catch(e){
  //     throw Exception('Failed to get weather data: ${e.message}');
  //   }
  // }
  //
  //
  //
  //
  // // Example of POST request
  // Future<WeatherModel> createWeatherAlert({
  //   required String city,
  //   required double temperature,
  // }) async {
  //   try {
  //     final response = await _httpClient.post(
  //       '/alerts',
  //       body: {
  //         'city': city,
  //         'temperature': temperature,
  //       },
  //       converter: (json) => WeatherModel.fromJson(json),
  //     );
  //
  //     return response.data;
  //   } catch (e) {
  //     throw Exception('Failed to create weather alert: ${e.toString()}');
  //   }
  // }
  //
  // // Example of PUT request
  // Future<WeatherModel> updateWeatherAlert({
  //   required String alertId,
  //   required Map<String, dynamic> data,
  // }) async {
  //   try {
  //     final response = await _httpClient.put(
  //       '/alerts/$alertId',
  //       body: data,
  //       converter: (json) => WeatherModel.fromJson(json),
  //     );
  //
  //     return response.data;
  //   } catch (e) {
  //     throw Exception('Failed to update weather alert: ${e.toString()}');
  //   }
  // }
  //


  void dispose() {
    _httpClient.dispose();
  }

}
