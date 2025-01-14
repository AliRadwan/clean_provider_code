class WeatherModel extends Weather {
  WeatherModel({
    required double temperature,
    required String description,
    required double humidity,
    required String cityName,
    required String iconCode,
  }) : super(
    temperature: temperature,
    description: description,
    humidity: humidity,
    cityName: cityName,
    iconCode: iconCode,
  );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      humidity: (json['main']['humidity'] as num).toDouble(),
      cityName: json['name'],
      iconCode: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'description': description,
      'humidity': humidity,
      'cityName': cityName,
      'iconCode': iconCode,
    };
  }
}

class Weather {
  final double temperature;
  final String description;
  final double humidity;
  final String cityName;
  final String iconCode;

  Weather({
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.cityName,
    required this.iconCode,
  });
}