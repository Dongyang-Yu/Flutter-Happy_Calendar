import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'weather_screen.dart';
import 'package:flutter_calendar/tools/iconImage.dart';

import 'package:flutter_calendar/tools/weatherMap.dart';
import 'package:flutter_calendar/tools/weatherInfo.dart';
import 'package:weather_icons/weather_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        WeatherScreen.id: (context) => WeatherScreen(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  static String id = 'calendar_screen';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  var weatherData;
  WeatherInfo weatherInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _events = {};
    _eventController = TextEditingController();
    _selectedEvents = [];
    initPrefs();

    getLocationData();
  }

  void getLocationData() async {
    weatherData = await WeatherMap().getLocationWeather();
    weatherInfo = WeatherInfo(weatherData);
    setState(() {
      if (weatherData == null) {
        weatherInfo.iconCode = '0';
        return;
      } else {
        weatherInfo.iconCode = weatherData['weather'][0]['icon'];
      }
    });
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    getLocationData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => ListTile(
                  title: Text(event),
                )),
// ***********************************************HERE*************************************************
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF74DBDB),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 1.0,
                ),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        IconImage.getIconData(weatherInfo.iconCode),
                        size: 50,
                        color: Color(0xFFEA6D4A),
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Text(
                        weatherInfo.cityName,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Weather',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "${weatherInfo.temperature}°C",
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                      Text(
                        "${weatherInfo.description}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'WeatherIcon',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Container(
                    height: 60,
                    child: FlatButton(
                        color: Color(0xFFDAF6F6),
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Color(0xFFDAF6F6),
                          ),
                        ),
                        child: Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WeatherScreen(
                              weather: weatherData,
                            );
                          }));
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: <Widget>[
          RaisedButton(
            child: Text('Add'),
            onPressed: _showAddDialog,
          ),
          RaisedButton(
            child: Text('Delete'),
            onPressed: () {
              if (_eventController.text.isEmpty) return;
              setState(() {
                _eventController.clear();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: TextField(
                      controller: _eventController,
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  _showAddDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("SAVE"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    setState(() {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            .add(_eventController.text);
                      } else {
                        _events[_controller.selectedDay] = [
                          _eventController.text
                        ];
                      }
                      prefs.setString(
                          "events", json.encode(encodeMap(_events)));
                      _eventController.clear();
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ));
  }
}
