// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:skycast/weather_api.dart';
import 'package:skycast/weather_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skycast App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;
  WeatherApi _weatherApi = WeatherApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skycast',
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xff2bc0e4), Color(0xffeaecc6)],
            stops: [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
              ),
              onSubmitted: (value) => _search(),
            ),
            SizedBox(height: 20.0),
            if (_weather != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _weather!.cityName,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '${_weather!.temperature.toStringAsFixed(1)}°C',
                    style: TextStyle(fontSize: 32.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    _weather!.description,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _search() {
    final cityName = _cityController.text;
    _weatherApi.fetchWeather(cityName).then((weather) {
      setState(() {
        _weather = weather;
      });
    }).catchError((e) {
      print('Error fetching weather data: $e');
      // Handle error gracefully
    });
  }
}
