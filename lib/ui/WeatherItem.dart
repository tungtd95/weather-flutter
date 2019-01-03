import 'package:flutter/material.dart';
import 'package:weather_flutter/model/Weather.dart';

class WeatherItem extends StatelessWidget {
  final Weather weather;
  final Function(Weather weather) onClick;
  final Function(Weather weather) onFavorite;

  WeatherItem(
      {@required this.weather,
      @required this.onClick,
      @required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: InkWell(
        child: ListTile(
          onTap: () {
            onClick(weather);
          },
          trailing: favoriteWidget(),
          isThreeLine: true,
          title: Text(weather.location),
          subtitle: Text("${weather.temp.toInt()}°C\n${weather.main}"),
          leading: Icon(Icons.location_city),
        ),
      ),
    );
  }

  Widget favoriteWidget() {
    return IconButton(
      icon: weather.favorite
          ? Icon(
              Icons.favorite,
              color: Colors.redAccent,
            )
          : Icon(
              Icons.favorite_border,
              color: Color.fromARGB(99, 255, 0, 0),
            ),
      onPressed: () {
        onFavorite(weather);
      },
    );
  }
}
