import 'package:clean_provider_code/core/network/http_client.dart';
import 'package:clean_provider_code/feature/data/weather_api_service.dart';
import 'package:clean_provider_code/feature/data/weather_api_service_impl.dart';
import 'package:clean_provider_code/feature/provider/theme_provider.dart';
import 'package:clean_provider_code/feature/provider/weather_provider.dart';
import 'package:clean_provider_code/feature/repo/weather_repository.dart';
import 'package:clean_provider_code/feature/repo/weather_repository_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future <void> setupServiceLocator() async {

  // Core
  getIt.registerLazySingleton(() => HttpClient(baseUrl: 'https://api.openweathermap.org/data/2.5'));

  // Data sources
  getIt.registerLazySingleton<WeatherApiService>(() => WeatherApiServiceImpl(apiKey: '271ec1a16cdb98daa8e69ba3cbad9cf7'));

  // Repositories
  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(weatherApiService: getIt<WeatherApiService>()));

  getIt.registerLazySingleton(()=> ThemeProvider());
  // Providers
  getIt.registerFactory<WeatherProvider>(()=>WeatherProvider(weatherRepository: getIt<WeatherRepository>(), themeProvider: getIt<ThemeProvider>()));

}