import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class mainComponent extends StatefulWidget {
  const mainComponent({Key? key, required this.data}) : super(key: key);

  final Map data;

  @override
  State<mainComponent> createState() => _mainComponentState();
}

class _mainComponentState extends State<mainComponent> {
  TextStyle textStyle() {
    return const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        widget.data['location']['localtime_epoch'] * 1000);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https:' + widget.data['current']['condition']['icon'],
              ),
              Text(
                widget.data['current']['temp_c'].toString() + 'ºC',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.data['current']['condition']['text'],
                style: textStyle(),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Row(
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
                          ),
                          const Icon(
                            Icons.air,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                              widget.data['forecast']['forecastday'][0]['day']
                                          ['maxtemp_c']
                                      .toString() +
                                  'º C',
                              style: textStyle()),
                          Text(
                              widget.data['forecast']['forecastday'][0]['day']
                                          ['mintemp_c']
                                      .toString() +
                                  'º C',
                              style: textStyle()),
                          Text(
                              widget.data['current']['wind_kph'].toString() +
                                  ' km/h',
                              style: textStyle()),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Icon(
                            Icons.speed,
                            color: Colors.green,
                          ),
                          const Icon(
                            Icons.water,
                            color: Colors.blueAccent,
                          ),
                          const Icon(
                            Icons.hourglass_bottom,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                              widget.data['current']['pressure_mb'].toString() +
                                  ' hPa',
                              style: textStyle()),
                          Text(
                              widget.data['current']['humidity'].toString() +
                                  '%',
                              style: textStyle()),
                          Text(
                              date.hour.toString() +
                                  ':' +
                                  date.minute.toString(),
                              style: textStyle()),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
