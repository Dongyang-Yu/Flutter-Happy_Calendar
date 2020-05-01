import 'package:flutter_calendar/tools/location.dart';
import 'package:flutter_calendar/tools/networking.dart';
import 'package:flutter/material.dart';

const weatherApiKey = '28e3a47a4cd1dfc05312d2eae677daed';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherMap {
  // get user location
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$weatherApiKey&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }


  String getMessage(int temp) {
    if (temp > 25) {
      return "It's time for ice cream!";
    } else if (temp > 20) {
      return 'Time for shorts and T-shirts';
    } else if (temp < 10) {
      return "It's a somewhat milder form of winter - though it can feel a little cold if you’re not used to it and aren’t suitably dressed. At 10°C, you can afford to pull off your trendy minimal outerwear like a parka, biker jacket or leather jacket. You can also get away with wearing your favourite shirt and jeans or dress combo, so long as you layer it with some form of outerwear.";
    } else if (temp > 5) {
      return "As temperatures drop into the single digits, forget your lightweight tops; instead, pack in thicker sweaters, jumpers, and turtlenecks to keep you extra warm underneath your coat. Choosing the right fabrics (like knits, cashmere, wool) is also as important as what you layer. For extra warmth, we recommend wearing your thermal underwear beneath to keep you extra toasty.";
    } else {
      return "Once the weather starts to reach freezing point, look for ‘heavy duty’ double-layered and hooded down jackets. Choosing the right type of fabric for both your inner and outerwear is also of utmost importance. For sub-zero temperatures, fleece lining, down, wool, and even polyester-blends should be your go-to options.";
    }
  }
}

//class _IconData extends IconData {
//  const _IconData(int codePoint)
//      : super(
//          codePoint,
////          fontFamily: 'WeatherIcons',
//        );
//}
//
//class WeatherIcons {
//  static const IconData clear_day = const _IconData(0xf00d);
//  static const IconData clear_night = const _IconData(0xf02e);
//
//  static const IconData few_clouds_day = const _IconData(0xf002);
//  static const IconData few_clouds_night = const _IconData(0xf081);
//
//  static const IconData clouds_day = const _IconData(0xf07d);
//  static const IconData clouds_night = const _IconData(0xf080);
//
//  static const IconData shower_rain_day = const _IconData(0xf009);
//  static const IconData shower_rain_night = const _IconData(0xf029);
//
//  static const IconData rain_day = const _IconData(0xf008);
//  static const IconData rain_night = const _IconData(0xf028);
//
//  static const IconData thunder_storm_day = const _IconData(0xf010);
//  static const IconData thunder_storm_night = const _IconData(0xf03b);
//
//  static const IconData snow_day = const _IconData(0xf00a);
//  static const IconData snow_night = const _IconData(0xf02a);
//
//  static const IconData mist_day = const _IconData(0xf003);
//  static const IconData mist_night = const _IconData(0xf04a);
//}
