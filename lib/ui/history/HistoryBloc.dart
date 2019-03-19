import 'dart:async';

import 'package:weather_flutter/data/WeatherRepoImpl.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';
import 'package:weather_flutter/ui/base/bloc_base.dart';

class HistoryBloc extends BlocBase {
  WeatherRepo weatherRepo = WeatherRepoImpl();

  //Weather list stream
  StreamController streamWeathersController =
      StreamController<List<Weather>>.broadcast();
  Sink get weathersSink => streamWeathersController.sink;
  Stream<List<Weather>> get weathersStream => streamWeathersController.stream;

  HistoryBloc() {
    updateWeather();
  }

  void updateWeather() async {
    var weathers = await weatherRepo.getWeathers();
    weathersSink.add(weathers);
  }

  void updateFavorite(Weather weather) async {
    weather.favorite = !weather.favorite;
    await weatherRepo.saveWeather(weather);
  }

  void deleteWeather(Weather weather) async {
    await weatherRepo.removeWeather(weather);
    updateWeather();
  }

  @override
  void dispose() {
    streamWeathersController.close();
  }
}
