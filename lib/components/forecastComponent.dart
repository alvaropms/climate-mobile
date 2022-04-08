import 'package:climate_mobile/models/forecastWeather.dart';
import 'package:flutter/material.dart';

class forecastComponent extends StatefulWidget {
  const forecastComponent({Key? key, required this.data}) : super(key: key);

  final ForecastWeather data;

  @override
  State<forecastComponent> createState() => _forecastComponentState();
}

class _forecastComponentState extends State<forecastComponent> {
  TextStyle textStyle() {
    return const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
  }

  String formatDate(String date) {
    var aux = date.split('-');
    return aux[2] + '/' + aux[1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                formatDate(widget.data.date),
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
                    widget.data.maxTemp.toString() + 'º C',
                    style: textStyle(),
                  ),
                  Text(
                    widget.data.minTemp.toString() + 'º C',
                    style: textStyle(),
                  )
                ],
              ),
              Column(
                children: [Image.network(widget.data.iconUrl)],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.data.condition,
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
