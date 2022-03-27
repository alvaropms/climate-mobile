import 'dart:convert';

import 'package:climate_mobile/components/cardComponent.dart';
import 'package:climate_mobile/components/forecastComponent.dart';
import 'package:climate_mobile/components/mainComponent.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  Map data = {};

  @override
  void initState() {
    var response = Dio().get(
        'https://api.weatherapi.com/v1/forecast.json?key=8e921b0c9085484cb1a12201220902&q=London&days=3&aqi=yes&alerts=no&lang=pt');
    response.then((value) {
      setState(() {
        data = value.data;
      });
      isLoading = false;
    });
    super.initState();
  }

  List<Widget> listElements() {
    if (!isLoading) {
      return [
        cardComponent(
          child: mainComponent(data: data),
        ),
        cardComponent(
            child: forecastComponent(data: data['forecast']['forecastday'][0])),
        cardComponent(
            child: forecastComponent(data: data['forecast']['forecastday'][1])),
        cardComponent(
            child: forecastComponent(data: data['forecast']['forecastday'][2]))
      ];
    }

    return [Text('Carregando')];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: false,
          centerTitle: false,
          title: const Text('Climate'),
          actions: const [],
          bottom: AppBar(
            title: Container(
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Procurar cidade',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(listElements()),
        ),
      ],
    );
  }
}
