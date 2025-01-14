import 'package:clean_provider_code/core/di/service_locator.dart';
import 'package:clean_provider_code/feature/data/weather_api_service_impl.dart';
import 'package:clean_provider_code/feature/provider/weather_provider.dart';
import 'package:clean_provider_code/feature/repo/weather_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
 // final weatherApiService = WeatherApiServiceImpl(apiKey: '271ec1a16cdb98daa8e69ba3cbad9cf7');
// final weatherRepository = WeatherRepositoryImpl(weatherApiService: weatherApiService);

WidgetsFlutterBinding.ensureInitialized();
await setupServiceLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> getIt<WeatherProvider>())
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
    );
  }
}



class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      context
                          .read<WeatherProvider>()
                          .getWeatherByCity(_cityController.text);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.isLoading) {
                  return const CircularProgressIndicator();
                }

                if (weatherProvider.error != null) {
                  return Text(
                    weatherProvider.error!,
                    style: const TextStyle(color: Colors.red),
                  );
                }

                final weather = weatherProvider.weather;
                if (weather == null) {
                  return const Text('Enter a city name to get weather data');
                }

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          weather.cityName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        Image.network(
                          'https://openweathermap.org/img/w/${weather.iconCode}.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          '${weather.temperature.toStringAsFixed(1)}°C',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          weather.description,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        Text('Humidity: ${weather.humidity}%'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}