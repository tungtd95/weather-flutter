import 'package:flutter/material.dart';
import 'package:weather_flutter/model/Weather.dart';

class WeatherScreen extends StatelessWidget {
  final Weather weather;

  WeatherScreen(this.weather);

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(weather.lastUpdated);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 24),
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                weather.location,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: 180,
              margin: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      weather.main,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      weather.des,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Temperature: ${weather.temp.toInt()}°C",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Humidity: ${weather.humidity.toInt()}%",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 320),
              child: Text(
                "Last updated ${dateTime.day}/${dateTime.month}/"
                    "${dateTime.year} ${dateTime.hour}:"
                    "${dateTime.minute ~/ 10 == 0 ? "0${dateTime.minute}" : dateTime.minute}",
                style: TextStyle(color: Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }
}
