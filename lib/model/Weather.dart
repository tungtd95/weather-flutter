class Weather {
  int id;
  String location;
  String main;
  String des;
  num temp;
  num pressure;
  num humidity;
  num tempMin;
  num tempMax;
  int lastUpdated;
  bool favorite;

  Weather(this.id, this.location, this.main, this.des, this.temp, this.pressure,
      this.humidity, this.tempMin, this.tempMax, this.lastUpdated, {this.favorite = false});
}
