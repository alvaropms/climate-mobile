class CurrentWeather {
  int date = 0;
  String iconUrl = '';
  double temp = 0;
  String condition = '';
  double maxTemp = 0;
  double minTemp = 0;
  double wind = 0;
  double pressure = 0;
  int humidity = 0;
  String city = '';
  String country = '';
  Map all = {};

  CurrentWeather(Map data) {
    setData(data);
  }

  setData(Map data) {
    date = data['location']?['localtime_epoch'] ?? 0;
    iconUrl = 'https:' + (data['current']?['condition']?['icon'] ?? '');
    temp = data['current']?['temp_c'] ?? 0;
    condition = data['current']?['condition']?['text'] ?? '';
    maxTemp = data['forecast']?['forecastday']?[0]?['day']?['maxtemp_c'] ?? 0;
    minTemp = data['forecast']?['forecastday']?[0]?['day']?['mintemp_c'] ?? 0;
    wind = data['current']?['wind_kph'] ?? 0;
    pressure = data['current']?['pressure_mb'] ?? 0;
    humidity = data['current']?['humidity'] ?? 0;
    city = data['location']?['name'] ?? '';
    country = data['location']?['country'] ?? '';
    all = data;
  }
}
