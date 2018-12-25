import 'package:weather_flutter/data/local/WeatherDao.dart';
import 'package:weather_flutter/data/remote/WeatherApi.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';

class WeatherRepoImpl with WeatherRepo {
  WeatherApi weatherApi = WeatherApi();
  WeatherDao weatherDao = WeatherDao();

  @override
  Future<Weather> getWeatherByLocation(String location) async {
    Weather weather = await weatherApi.findWeatherByLocation(location);
    if (weather == null) {
      weather = await weatherDao.getWeatherByLocation(location);
    } else {
      await weatherDao.saveWeather(weather);
    }
    return weather;
  }

  @override
  Future<List<Weather>> getWeathers() {
    return weatherDao.getWeathers();
  }

  @override
  Future<void> removeWeather(Weather weather) {
    return weatherDao.removeWeather(weather);
  }
}
