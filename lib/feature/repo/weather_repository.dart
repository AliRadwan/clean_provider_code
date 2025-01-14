import 'package:clean_provider_code/feature/model/weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherByCity(String cityName);
}