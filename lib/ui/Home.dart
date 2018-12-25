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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 80,
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: MaterialSearch<String>(
                placeholder: "Enter location",
                results: [],
                onSubmit: (String value) {
                  getWeatherByName(value);
                },
              )),
          Container(
            child: Row(
              children: <Widget>[displayResult(), displayLoading()],
            ),
          ),
        ],
      ),
    );
  }

  Container displayResult() {
    if (weather == null) {
      return Container(
          height: 60,
          width: 260,
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20));
    } else {
      return Container(
          height: 60,
          width: 260,
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
          decoration: BoxDecoration(color: Colors.black12),
          child: Text(
            weather?.location,
            style: TextStyle(fontSize: 18),
          ));
    }
  }

  Container displayLoading() {
    if (isLoading) {
      return Container(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      );
    } else {
      return Container(height: 24, width: 24);
    }
  }

  void getWeatherByName(String name) async {
    setState(() {
      isLoading = true;
      this.weather = null;
    });
    Weather weather = await weatherRepo.getWeatherByLocation(name);
    setState(() {
      isLoading = false;
      this.weather = weather;
    });
  }
}
