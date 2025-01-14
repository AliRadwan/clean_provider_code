import 'package:clean_provider_code/feature/model/weather_model.dart';
import 'package:clean_provider_code/feature/repo/weather_repository.dart';
import 'package:flutter/material.dart';

class WeatherProvider extends ChangeNotifier {
final WeatherRepository _weatherRepository;

  WeatherProvider({required WeatherRepository weatherRepository}): _weatherRepository = weatherRepository;


  Weather? _weather;
  bool _isLoading = false;
  String? _error;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getWeatherByCity(String cityName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
     _weather = await _weatherRepository.getWeatherByCity(cityName);
     _error = null;
    } catch (e) {
      _error = e.toString();
      _weather = null;
    }
    _isLoading = false;
    notifyListeners();
  }
}