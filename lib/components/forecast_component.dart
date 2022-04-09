import 'package:climate_mobile/models/forecast_weather.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/api.dart';

class ForecastComponent extends StatefulWidget {
  const ForecastComponent({Key? key, required this.day}) : super(key: key);

  final int day;

  @override
  State<ForecastComponent> createState() => _ForecastComponentState();
}

class _ForecastComponentState extends State<ForecastComponent> {
  TextStyle textStyle() {
    return const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
  }

  String formatDate(String date) {
    var aux = date.split('-');
    return aux[2] + '/' + aux[1];
  }

  late ForecastWeather data;

  @override
  Widget build(BuildContext context) {
    switch (widget.day) {
      case 0:
        data = GetIt.I.get<Api>().data.today;
        break;
      case 1:
        data = GetIt.I.get<Api>().data.tomorrow;
        break;
      case 2:
        data = GetIt.I.get<Api>().data.afterTomorrow;
        break;
      default:
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                formatDate(data.date),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(
                    Icons.device_thermostat,
                    color: Colors.red,
                  ),
                  const Icon(
                    Icons.device_thermostat,
                    color: Colors.blue,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    data.maxTemp.toString() + 'º C',
                    style: textStyle(),
                  ),
                  Text(
                    data.minTemp.toString() + 'º C',
                    style: textStyle(),
                  )
                ],
              ),
              Column(
                children: [Image.network(data.iconUrl)],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  data.condition,
                  style: textStyle(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
