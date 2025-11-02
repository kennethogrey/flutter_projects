import 'dart:convert';

import 'package:weather_app_api/data/data_provider/weather_data_provider.dart';
import 'package:weather_app_api/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String city = 'Mukono';
      final weatherData = await weatherDataProvider.getCurrentWeather(city);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An Unexpected error occured.';
      }

      return WeatherModel.fromJson(weatherData);
    } catch (e) {
      throw e.toString();
    }
  }
}
