import 'package:clean_provider_code/feature/model/weather_model.dart';
import 'package:clean_provider_code/feature/provider/theme_provider.dart';
import 'package:clean_provider_code/feature/repo/weather_repository.dart';
import 'package:flutter/material.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _weatherRepository;
  final ThemeProvider _themeProvider;

  WeatherProvider(
      {required WeatherRepository weatherRepository,
      required ThemeProvider themeProvider})
      : _weatherRepository = weatherRepository,
        _themeProvider = themeProvider;

  Weather? _weather;
  bool _isLoading = false;
  String? _error;

  Weather? get weather => _weather;

  bool get isLoading => _isLoading;

  String? get error => _error;

  bool get isDarkMode => _themeProvider.isDarkMode;


  // Get weather card color based on temperature and theme
  Color getWeatherCardColor(BuildContext context) {
    if (_weather == null) return Theme.of(context).cardColor;

    final isDark = _themeProvider.isDarkMode;
    if (_weather!.temperature > 25) {
      return isDark ? Colors.red.shade900 : Colors.red.shade100;
    } else if (_weather!.temperature < 10) {
      return isDark ? Colors.blue.shade900 : Colors.blue.shade100;
    }
    return Theme.of(context).cardColor;
  }

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
