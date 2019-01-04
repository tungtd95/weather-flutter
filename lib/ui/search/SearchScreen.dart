import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather_flutter/ui/WeatherItem.dart';
import 'package:weather_flutter/ui/search/SearchViewModel.dart';
import 'package:weather_flutter/ui/weather/WeatherScreen.dart';

class SearchScreen extends StatelessWidget with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: SearchViewModel.getInstance(),
      child: WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Search weather"),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              searchWidget(),
              searchResult(),
            ],
          ),
        ),
        onWillPop: () async {
          SearchViewModel.destroyInstance();
          Navigator.pop(context, "pop from search");
        },
      ),
    );
  }

  Widget searchResult() => ScopedModelDescendant<SearchViewModel>(
        builder: (BuildContext context, Widget child, SearchViewModel model) {
          return model.weatherSearched == null
              ? Container()
              : WeatherItem(
                  weather: model.weatherSearched,
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
                    model.favorite();
                  },
                );
        },
      );

  Widget searchWidget() => ScopedModelDescendant<SearchViewModel>(
        builder: (BuildContext context, Widget child, SearchViewModel model) {
          return Card(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(top: 6, bottom: 4),
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  TextField(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Enter location",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onSubmitted: (String input) {
                      model.getWeatherByLocation(input);
                    },
                  ),
                  loadingLocationWidget(model.isLoadingLocation),
                ],
              ),
            ),
          );
        },
      );

  Widget loadingLocationWidget(bool isLoading) {
    return Container(
      width: 20,
      height: 20,
      margin: EdgeInsets.only(right: 16),
      child: isLoading
          ? CircularProgressIndicator(
              strokeWidth: 2,
            )
          : null,
    );
  }
}
