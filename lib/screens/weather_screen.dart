import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/screens/main.dart';
import 'package:flutter_calendar/tools/iconImage.dart';
import 'package:flutter_calendar/tools/weatherMap.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar/tools/weatherInfo.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.weather});
  final weather;

  static String id = 'weather_screen';
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherInfo weather;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weather = WeatherInfo(widget.weather);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: Container(
        child: SafeArea(
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    "${weather.cityName}",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Weather',
                    ),
                  ),
                ),
              ),
              Text("${weather.description}"),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular((20.0)),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Humidity"),
                            Text("${weather.humidity}%"),
                            Text(
                              "Max temperature",
                              style: TextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text("${weather.temperatureMax}%"),
                            Text(
                              "Min temperature",
                              style: TextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text("${weather.temperatureMin}%"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            IconImage.getIconData(weather.iconCode),
                            size: 60.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            '${weather.temperature}°C',
//                      style: kTempTextStyle,
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "Advice: ${weather.advice}",
                  textAlign: TextAlign.right,
//                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
