import 'package:flutter/material.dart';
import 'package:weather_flutter/data/WeatherRepoImpl.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';

class Home extends StatelessWidget {

  WeatherRepo weatherRepo = WeatherRepoImpl();

  @override
  Widget build(BuildContext context) {
    print("getting weather");
    getWeatherByName("hanoi");
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: Text("Hello World"),
        ));
  }

  void getWeatherByName(String name) async {
    Weather weather = await weatherRepo.getWeatherByLocation(name);
    print(weather.location);
  }
}
