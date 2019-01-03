import 'package:flutter/material.dart';
import 'package:weather_flutter/model/Weather.dart';

class WeatherItem extends StatelessWidget {
  final Weather weather;
  final Function(Weather weather) onClick;
  final Function(Weather weather) onFavorite;
  final Function(Weather weather) onDelete;
  final bool deleteAble;

  WeatherItem(
      {@required this.weather,
      @required this.onClick,
      @required this.onFavorite,
      this.onDelete,
      this.deleteAble});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "hero tag container ${weather.location}",
      child: Card(
        elevation: 3,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: InkWell(
          child: ListTile(
            onTap: () {
              onClick(weather);
            },
            onLongPress: () {
              if (deleteAble)
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("Delete ${weather.location}?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Cancel",
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          onPressed: () {
                            onDelete(weather);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Yes",
                          ),
                        ),
                      ],
                    );
                  },
                );
            },
            trailing: favoriteWidget(),
            isThreeLine: true,
            title: Hero(
              tag: "hero tag ${weather.location}",
              child: Container(
                width: 200,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "${weather.location}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  child: Material(
                    color: Colors.transparent,
                    child: Text("${weather.main}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        )),
                  ),
                  tag: "hero tag ${weather.location} main",
                ),
                Hero(
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "${weather.temp.toInt()}°C",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  tag: "hero tag ${weather.location} temp",
                )
              ],
            ),
            leading: Icon(Icons.location_city),
          ),
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
