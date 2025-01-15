import 'package:clean_provider_code/core/network/http_client.dart';
import 'package:clean_provider_code/core/network/http_error.dart';
import 'package:clean_provider_code/feature/data/weather_api_service.dart';
import 'package:clean_provider_code/feature/model/weather_model.dart';

class WeatherApiServiceImpl  implements WeatherApiService {
  final HttpClient _httpClient;
  final String apiKey;

  WeatherApiServiceImpl({required this.apiKey}) : _httpClient = HttpClient(baseUrl: 'https://api.openweathermap.org/data/2.5',);
  
  
  @override
  Future <WeatherModel> getWeatherByCity(String cityName) async {
    try{
      final response =  await _httpClient.get('/weather',queryParams: {
        'q': cityName,
        'units': 'metric',
        'appid': apiKey
      });
      return WeatherModel.fromJson(response);
    } on HttpError catch(e){
      throw Exception('Failed to get weather data: ${e.message}');
    }
  }

  void dispose() {
    _httpClient.dispose();
  }

}
