import 'package:flutter_calendar/tools/weatherMap.dart';

class WeatherInfo {
//  WeatherInfo({this.weather});
  WeatherInfo(dynamic weatherData) {
    WeatherMap weather = WeatherMap();

    if (weatherData == null) {
      temperature = 0;
      temperatureMin = 0;
      temperatureMax = 0;
      weatherIcon = 'Error';
      advice = 'Unable to get weather data';
      cityName = 'Nowhere';
      iconCode = '0';
      description = "Unknown";
      return;
    }
    double temp = weatherData['main']['temp'].toDouble();
    double tempMin = weatherData['main']['temp_min'].toDouble();
    double tempMax = weatherData['main']['temp_max'].toDouble();
    temperature = temp.toInt();
    temperatureMin = tempMin.toInt();
    temperatureMax = tempMax.toInt();

    var condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    iconCode = weatherData['weather'][0]['icon'];
    weatherIcon = weather.getWeatherIcon(condition);
    advice = weather.getMessage(temperature);
    description = weatherData['weather'][0]['description'];
  }

//  final weather;

  String weatherIcon;
  int temperature;
  String cityName;
  String advice;
  String iconCode;
  String description;
  int humidity;
  int temperatureMin;
  int temperatureMax;
}
