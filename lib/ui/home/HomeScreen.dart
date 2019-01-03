import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather_flutter/ui/WeatherItem.dart';
import 'package:weather_flutter/ui/history/HistoryScreen.dart';
import 'package:weather_flutter/ui/home/HomeViewModel.dart';
import 'package:weather_flutter/ui/search/SearchScreen.dart';
import 'package:weather_flutter/ui/weather/WeatherScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: HomeViewModel.getInstance(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
          actions: <Widget>[
            searchWidget(context),
            historyWidget(),
          ],
        ),
        body: listFavoriteWeatherWidget(),
      ),
    );
  }

  Widget historyWidget() {
    return ScopedModelDescendant<HomeViewModel>(
      builder: (BuildContext context, Widget child, HomeViewModel model) {
        return IconButton(
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HistoryScreen();
                },
              ),
            );
            if (result != null) {
              model.updateWeatherFavorite();
            }
          },
          icon: Icon(Icons.history),
        );
      },
    );
  }

  Widget searchWidget(BuildContext context) =>
      ScopedModelDescendant<HomeViewModel>(
        builder: (BuildContext context, Widget child, HomeViewModel model) {
          return IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
              if (result != null) {
                //update home view model
                model.updateWeatherFavorite();
              }
            },
          );
        },
      );

  Widget listFavoriteWeatherWidget() => ScopedModelDescendant<HomeViewModel>(
        builder: (BuildContext context, Widget child, HomeViewModel model) {
          return ListView.builder(
            itemCount: model.weatherFavorite.length,
            itemBuilder: (context, index) {
              return WeatherItem(
                weather: model.weatherFavorite[index],
                onClick: (weather) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WeatherScreen(weather: weather);
                      },
                    ),
                  );
                },
                onFavorite: (weather) {
                  model.updateFavorite(weather);
                },
                onDelete: (weather) {
                  model.deleteWeather(weather);
                },
                deleteAble: true,
              );
            },
          );
        },
      );
}
