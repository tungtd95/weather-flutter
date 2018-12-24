import 'package:weather_flutter/data/remote/WeatherApi.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';

class WeatherRepoImpl with WeatherRepo {

  WeatherApi weatherApi = WeatherApi();

  @override
  Future<Weather> getWeatherByLocation(String location) {
    return weatherApi.findWeatherByLocation(location);
  }

  @override
  Future<List<Weather>> getWeathers() {
    // TODO: implement getWeathers
    return null;
  }

  @override
  Future<void> removeWeather(Weather weather) {
    // TODO: implement removeWeather
    return null;
  }
}
