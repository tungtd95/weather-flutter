import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_flutter/model/Weather.dart';

class WeatherDao {
  final String tableName = "weather";
  final String id = "id";
  final String location = "location";
  final String main = "main";
  final String des = "des";
  final String temp = "temp";
  final String tempMax = "temp_max";
  final String tempMin = "temp_min";
  final String pressure = "pressure";
  final String humidity = "humidity";
  final String lastUpdated = "last_updated";

  Database database;

  Future<Database> open() async {
    if (database == null) {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, 'weathers.db');

      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS $tableName ($id INTEGER PRIMARY KEY, "
            "$location TEXT, $main TEXT, $des TEXT, $temp REAL, $tempMax REAL,"
            "$tempMin REAL, $pressure REAL, $humidity REAL, $lastUpdated INTEGER);");
      });
    }
    return database;
  }

  Future<int> saveWeather(Weather weather) async {
    Database db = await open();

    var map = Map<String, dynamic>();
    map[id] = weather.id;
    map[location] = weather.location;
    map[main] = weather.main;
    map[des] = weather.des;
    map[temp] = weather.temp;
    map[tempMax] = weather.tempMax;
    map[tempMin] = weather.tempMin;
    map[pressure] = weather.pressure;
    map[humidity] = weather.humidity;
    map[lastUpdated] = weather.lastUpdated;

    var result = await db.insert(tableName, map,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<Weather> getWeatherByLocation(String location) async {
    Database db = await open();

    List<Map<String, dynamic>> results = await db.query(tableName,
        where: "${this.location} LIKE '$location'", limit: 1);
    if (results == null || results.length == 0) {
      return null;
    } else {
      var result = results[0];
      return getWeatherFromRaw(result);
    }
  }

  Future<List<Weather>> getWeathers() async {
    Database db = await open();

    List<Map<String, dynamic>> results = await db.query(tableName);
    List<Weather> weathers = [];
    for (Map<String, dynamic> result in results) {
      weathers.add(getWeatherFromRaw(result));
    }
    return weathers;
  }

  Future<int> removeWeather(Weather weather) async {
    Database database = await open();
    int result = await database
        .rawDelete("DELETE FROM $tableName WHERE $id = ${weather.id};");
    return result;
  }

  Weather getWeatherFromRaw(Map<String, dynamic> result) {
    return Weather(
        result[id],
        result[this.location],
        result[main],
        result[des],
        result[temp],
        result[pressure],
        result[humidity],
        result[tempMin],
        result[tempMax],
        result[lastUpdated]);
  }
}
