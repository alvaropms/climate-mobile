import 'dart:convert';

import 'package:climate_mobile/components/cardComponent.dart';
import 'package:climate_mobile/components/forecastComponent.dart';
import 'package:climate_mobile/components/mainComponent.dart';
import 'package:climate_mobile/models/currentWeather.dart';
import 'package:climate_mobile/models/forecastWeather.dart';
import 'package:climate_mobile/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  CurrentWeather data = CurrentWeather({});
  Api services = Api();

  _initRequest() {
    services.getWeatherData().catchError((err) {
      services.errorDialog(context);
    }).then((value) {
      setState(() {
        data.setData(jsonDecode(value.toString()));
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _initRequest();
    super.initState();
  }

  _changeCity(String city) {
    setState(() {
      isLoading = true;
    });
    services.getWeatherDataByCity(city).catchError((err) {
      services.errorDialog(context);
      setState(() {
        isLoading = false;
      });
    }).then((value) {
      setState(() {
        data.setData(jsonDecode(value.toString()));
        isLoading = false;
      });
    });
  }

  List<Widget> listElements() {
    if (isLoading) {
      return [
        Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
          child: const SpinKitRing(
            color: Colors.blueGrey,
            size: 50.0,
          ),
        )
      ];
    }
    return [
      Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  'Tempo agora em ' + (data.city),
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Text(
                data.country,
                style: const TextStyle(fontSize: 10),
              )
            ],
          )),
      cardComponent(
        child: mainComponent(data: data),
      ),
      cardComponent(
          child: forecastComponent(data: ForecastWeather(data.all, 0))),
      cardComponent(
          child: forecastComponent(data: ForecastWeather(data.all, 1))),
      cardComponent(
          child: forecastComponent(data: ForecastWeather(data.all, 2)))
    ];
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
              child: Center(
                child: TextField(
                  onSubmitted: _changeCity,
                  decoration: const InputDecoration(
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
