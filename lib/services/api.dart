import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Api {
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

  Future getWeatherData() async {
    var res = await _getCity();
    res = jsonDecode(res.toString());
    Future request = _dio.get(_weatherUrl(res['city']));
    return request;
  }

  Future getWeatherDataByCity(String city) {
    Future request = _dio.get(_weatherUrl(city));
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
