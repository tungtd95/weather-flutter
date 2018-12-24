
import 'package:weather_flutter/model/Weather.dart';

abstract class WeatherRepo {

  Future<Weather> getWeatherByLocation(String location);

  Future<List<Weather>> getWeathers();

  Future<void> removeWeather(Weather weather);

}