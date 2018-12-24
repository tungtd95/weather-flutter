import 'package:weather_flutter/model/Weather.dart';

class WeatherFromApi {
  int id;
  String name;
  Main main;
  List<WeatherData> weathers;

  Weather toWeather() {
    return Weather(
        id,
        name,
        weathers[0]?.main,
        weathers[0]?.main,
        main?.temp,
        main?.pressure,
        main?.humidity,
        main?.tempMin,
        main?.tempMax,
        DateTime.now().millisecondsSinceEpoch);
  }
}

class Main {
  double temp;
  double pressure;
  double humidity;
  double tempMin;
  double tempMax;

  Main(this.temp, this.pressure, this.humidity, this.tempMin, this.tempMax);
}

class WeatherData {
  String main;
  String description;

  WeatherData(this.main, this.description);
}
