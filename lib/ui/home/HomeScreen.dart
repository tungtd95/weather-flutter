import 'package:flutter/material.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:material_search/material_search.dart';
import 'package:weather_flutter/ui/base/BaseView.dart';
import 'package:weather_flutter/ui/home/HomePresenter.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends BaseView {
  HomePresenter homePresenter;

  @override
  void initState() {
    super.initState();
    homePresenter = HomePresenter(this);
    homePresenter.updateWeathers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 80,
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: MaterialSearch<String>(
                placeholder: "Enter location",
                results: [],
                onSubmit: (String value) {
                  homePresenter.getWeatherByLocation(value);
                },
              )),
          Container(
            child: Row(
              children: <Widget>[displayResult(), displayLoading()],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              "history",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          Container(
              height: 370,
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(top: 0),
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: Colors.black54),
                  itemCount: homePresenter.weathers.length,
                  itemBuilder: (context, index) =>
                      buildItem(homePresenter.weathers[index])))
        ],
      ),
    );
  }

  Container displayResult() {
    if (homePresenter.weather == null) {
      return Container(
          height: 60,
          width: 260,
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20));
    } else {
      return Container(
          height: 60,
          width: 260,
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
          decoration: BoxDecoration(color: Colors.black12),
          child: Text(
            homePresenter.weather?.location,
            style: TextStyle(fontSize: 18),
          ));
    }
  }

  Container displayLoading() {
    if (homePresenter.isLoading) {
      return Container(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      );
    } else {
      return Container(height: 24, width: 24);
    }
  }

  Widget buildItem(Weather weather) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(weather.lastUpdated);
    return GestureDetector(
      onTap: () {
        //TODO: navigate to weather detail screen
      },
      child: Container(
          height: 60,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      weather.location,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      weather.main,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              Container(
                width: 144,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text("${weather.temp.toInt()}°C"),
                    Text(
                      "Last updated ${dateTime.day}/${dateTime.month}/"
                          "${dateTime.year} ${dateTime.hour}:"
                          "${dateTime.minute ~/ 10 == 0 ? "0${dateTime.minute}" : dateTime.minute}",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Container(
                width: 30,
                child: IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      homePresenter.removeWeather(weather);
                    }),
              ),
            ],
          )),
    );
  }
}
