import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Api {
  final String _key = '8e921b0c9085484cb1a12201220902';
  String city = 'London';
  String country = 'United Kingdon';
  final String _ipUrl = 'https://ipapi.co/json';

  final _dio = Dio();

  String _weatherUrl() {
    return 'https://api.weatherapi.com/v1/forecast.json?key=' +
        _key +
        '&q=' +
        city +
        '&days=3&aqi=yes&alerts=no&lang=pt';
  }

  Future getWeatherData() async {
    var res = await getCity();
    res = jsonDecode(res.toString());
    city = res['city'];
    return _dio.get(_weatherUrl());
  }

  Future getWeatherDataByCity(String city) {
    this.city = city;
    return _dio.get(_weatherUrl());
  }

  Future getCity() async {
    return _dio.get(_ipUrl);
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
