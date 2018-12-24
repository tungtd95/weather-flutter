import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/model/WeatherFromApi.dart';
import 'package:weather_flutter/utils/NetworkUtil.dart';

class WeatherApi {
  var client = Client();

  Future<Weather> findWeatherByLocation(String location) async {
    String url = "$BASE_URL/$WEATHER?$QUERY_PARAM=$location&$APP_ID_PARAM=$APP_ID";
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return WeatherFromApi.fromJson(json.decode(response.body))?.toWeather();
    } else {
      throw Exception("Load data error, response = ${response.body}");
    }
  }
}
