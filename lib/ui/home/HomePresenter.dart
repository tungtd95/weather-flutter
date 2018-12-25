import 'package:weather_flutter/data/WeatherRepoImpl.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';
import 'package:weather_flutter/ui/base/BasePresenter.dart';
import 'package:weather_flutter/ui/base/BaseView.dart';

class HomePresenter extends BasePresenter {

  WeatherRepo weatherRepo = WeatherRepoImpl();
  Weather weather;
  List<Weather> weathers = [];
  bool isLoading = false;

  HomePresenter(BaseView view) : super(view);

  void getWeatherByLocation(String location) async {
    isLoading = true;
    notifyDataChanged();
    weather = await weatherRepo.getWeatherByLocation(location);
    isLoading = false;
    notifyDataChanged();
    updateWeathers();
  }

  void updateWeathers() async {
    weathers = await weatherRepo.getWeathers();
    notifyDataChanged();
  }

  void removeWeather(Weather weather) async {
    await weatherRepo.removeWeather(weather);
    updateWeathers();
  }
}
