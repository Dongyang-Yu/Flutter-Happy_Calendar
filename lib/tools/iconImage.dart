import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class IconImage {
  static IconData getIconData(String iconCode) {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.day_sunny;
      case '01n':
        return WeatherIcons.night_clear;
      case '02d':
        return WeatherIcons.day_cloudy;
      case '02n':
        return WeatherIcons.night_cloudy;
      case '03d':
      case '04d':
        return WeatherIcons.cloudy_gusts;
      case '03n':
      case '04n':
        return WeatherIcons.night_cloudy_gusts;
      case '09d':
        return WeatherIcons.day_showers;
      case '09n':
        return WeatherIcons.night_showers;
      case '10d':
        return WeatherIcons.day_rain;
      case '10n':
        return WeatherIcons.night_rain;
      case '11d':
        return WeatherIcons.day_sleet_storm;
      case '11n':
        return WeatherIcons.night_sleet_storm;
      case '13d':
        return WeatherIcons.day_snow;
      case '13n':
        return WeatherIcons.night_snow;
      case '50d':
        return WeatherIcons.smog;
      case '50n':
        return WeatherIcons.smog;
      default:
        return WeatherIcons.na;
    }
  }
}
