class Weather {
  int id;
  String location;
  String main;
  String des;
  int temp;
  int pressure;
  int humidity;
  int tempMin;
  int tempMax;
  int lastUpdated;

  Weather(this.id, this.location, this.main, this.des, this.temp, this.pressure,
      this.humidity, this.tempMin, this.tempMax, this.lastUpdated);
}
