//  Singleton для погодного додатку на мові Dart:

import 'dart:convert';
import 'package:http/http.dart' as http;

// У цьому прикладі WeatherService є Singleton класом, який забезпечує доступ
// до API погоди. Це зроблено, щоб забезпечити один екземпляр класу
// WeatherService для всього додатку, що забезпечує ефективне використання
// пам'яті та зменшення кількості звернень до API.

// Метод getWeather() викликає API для отримання погоди для вказаного міста,
// використовуючи ключ API, який можна задати методом setApiKey().
// Клас Weather є простим класом даних, який містить інформацію про місто,
// температуру та опис погоди.

// У функції main ми задаємо ключ API перед викликом будь-яких методів,
// а потім отримуємо погоду, використовуючи WeatherService.instance.getWeather().

class WeatherService {
  static final WeatherService _instance = WeatherService._internal();

  factory WeatherService() {
    return _instance;
  }

  WeatherService._internal();

  late String _apiKey;

  void setApiKey(String key) {
    _apiKey = key;
  }

  Future<Weather> getWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get weather data');
    }
  }
}

class Weather {
  final String city;
  final double temperature;
  final String description;

  Weather(
      {required this.city,
      required this.temperature,
      required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final city = json['name'];
    final temperature = json['main']['temp'].toDouble();
    final description = json['weather'][0]['description'];
    return Weather(
        city: city, temperature: temperature, description: description);
  }
}

void main() async {
  // Задаємо ключ API перед викликом будь-яких методів
  WeatherService._instance.setApiKey('d7f3fb73c94b0165061b6b96fc397852');

  try {
    // Отримуємо погоду
    final weather = await WeatherService._instance.getWeather('Tarifa');
    print(
        'The temperature in ${weather.city} is ${weather.temperature} Celsius, with ${weather.description}');
  } catch (e) {
    print('Error getting weather data: $e');
  }
}
