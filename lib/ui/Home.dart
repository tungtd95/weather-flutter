import 'package:flutter/material.dart';
import 'package:weather_flutter/data/WeatherRepoImpl.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';
import 'package:material_search/material_search.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  WeatherRepo weatherRepo = WeatherRepoImpl();
  Weather weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialSearch<String>(
        placeholder: "Enter location",
        results: [],
        onSubmit: (String value) {
          getWeatherByName(value);
        },
      ),
    );
  }

  void getWeatherByName(String name) async {
    Weather weather = await weatherRepo.getWeatherByLocation(name);
    setState(() {
      this.weather = weather;
    });
  }
}
