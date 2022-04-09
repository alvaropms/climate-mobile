import 'dart:convert';
import 'package:climate_mobile/models/current_weather.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'api.g.dart';

class Api = _Api with _$Api;

abstract class _Api with Store {
  @observable
  CurrentWeather data = CurrentWeather({});
  @observable
  bool isLoading = false;

  final String _key = const String.fromEnvironment('APIKEY');
  final String _ipUrl = 'https://ipapi.co/json';

  final _dio = Dio();

  String _weatherUrl(city) {
    return 'https://api.weatherapi.com/v1/forecast.json?key=' +
        _key +
        '&q=' +
        city +
        '&days=3&aqi=yes&alerts=no&lang=pt';
  }

  Future _getCity() async {
    return _dio.get(_ipUrl);
  }

  @action
  Future getWeatherData() async {
    isLoading = true;
    var res = await _getCity();
    res = jsonDecode(res.toString());
    Future request = _dio.get(_weatherUrl(res['city']));
    request.then((value) {
      data.setData(jsonDecode(value.toString()));
    }).whenComplete(() => isLoading = false);
    return request;
  }

  @action
  Future getWeatherDataByCity(String city) {
    isLoading = true;
    Future request = _dio.get(_weatherUrl(city));
    request.then((value) {
      data.setData(jsonDecode(value.toString()));
    }).whenComplete(() => isLoading = false);
    return request;
  }

  errorDialog(context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Erro!'),
        content: const Text('Não foi possível realizar esta busca'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
