import 'package:flutter/material.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/ui/WeatherItem.dart';
import 'package:weather_flutter/ui/base/bloc_base.dart';
import 'package:weather_flutter/ui/history/HistoryBloc.dart';
import 'package:weather_flutter/ui/weather/WeatherScreen.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("History"),
        ),
        body: BlocProvider(
          bloc: HistoryBloc(),
          child: weathersWidget(context),
        ),
      ),
      onWillPop: () {
        Navigator.pop(context, "pop from history screen");
      },
    );
  }

  Widget weathersWidget(BuildContext context) {
    HistoryBloc bloc = BlocProvider.of(context);
    return StreamBuilder<List<Weather>>(
      initialData: [],
      stream: bloc.weathersStream,
      builder: (BuildContext context, AsyncSnapshot<List<Weather>> snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return WeatherItem(
              onFavorite: (Weather weather) {
                bloc.updateFavorite(weather);
              },
              onClick: (Weather weather) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WeatherScreen(
                        snapshot.data.indexOf(weather),
                        snapshot.data,
                      );
                    },
                  ),
                );
              },
              weather: snapshot.data[index],
              onDelete: (Weather weather) {
                bloc.deleteWeather(weather);
              },
              deleteAble: true,
            );
          },
        );
      },
    );
  }
}
