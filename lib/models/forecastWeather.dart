class ForecastWeather {
  String date = '';
  double maxTemp = 0;
  double minTemp = 0;
  String iconUrl = '';
  String condition = '';

  ForecastWeather(Map data, int i) {
    setData(data, i);
  }

  setData(Map data, int i) {
    date = data['forecast']?['forecastday']?[i]?['date'] ?? '';
    maxTemp = data['forecast']?['forecastday']?[i]?['day']?['maxtemp_c'] ?? 0;
    minTemp = data['forecast']?['forecastday']?[i]?['day']?['mintemp_c'] ?? 0;
    iconUrl = "https:" +
        (data['forecast']?['forecastday']?[i]?['day']?['condition']?['icon'] ??
            '');
    condition = data['forecast']?['forecastday']?[i]?['day']?['condition']
            ?['text'] ??
        '';
  }
}
