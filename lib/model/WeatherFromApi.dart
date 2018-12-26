import 'package:weather_flutter/model/Weather.dart';

class WeatherFromApi {
  int id;
  String name;
  Main main;
  List<WeatherData> weathers;

  WeatherFromApi({this.id, this.name, this.main});

  WeatherFromApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    main = Main.fromJson(json['main']);
    weathers = [];
    for (var value in json['weather']) {
      weathers.add(WeatherData.fromJson(value));
    }
  }

  Weather toWeather() {
    return Weather(
        id,
        name,
        weathers[0]?.main,
        weathers[0]?.description,
        main?.temp,
        main?.pressure,
        main?.humidity,
        main?.tempMin,
        main?.tempMax,
        DateTime.now().millisecondsSinceEpoch);
  }
}

class Main {
  num temp;
  num pressure;
  num humidity;
  num tempMin;
  num tempMax;

  Main(this.temp, this.pressure, this.humidity, this.tempMin, this.tempMax);

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
  }
}

class WeatherData {
  String main;
  String description;

  WeatherData(this.main, this.description);

  WeatherData.fromJson(Map<String, dynamic> json) {
    main = json['main'];
    description = json['description'];
  }
}
