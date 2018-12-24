class Weather {
  int id;
  String location;
  String main;
  String des;
  double temp;
  double pressure;
  double humidity;
  double tempMin;
  double tempMax;
  int lastUpdated;

  Weather(this.id, this.location, this.main, this.des, this.temp, this.pressure,
      this.humidity, this.tempMin, this.tempMax, this.lastUpdated);
}
