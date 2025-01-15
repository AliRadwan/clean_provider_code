import 'package:clean_provider_code/feature/data/weather_api_service.dart';
import 'package:clean_provider_code/feature/model/weather_model.dart';
import 'package:clean_provider_code/feature/repo/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherApiService _weatherApiService;

  WeatherRepositoryImpl({required WeatherApiService weatherApiService}) : _weatherApiService = weatherApiService;
  @override
  Future<Weather> getWeatherByCity(String cityName) async {
    try{
      return await _weatherApiService.getWeatherByCity(cityName);
    }catch(e){
      throw Exception('Repository Error: Failed to get weather data - $e');
    }
  }
}