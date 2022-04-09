import 'package:climate_mobile/models/current_weather.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/api.dart';

class MainComponent extends StatefulWidget {
  const MainComponent({Key? key}) : super(key: key);

  @override
  State<MainComponent> createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent> {
  TextStyle textStyle() {
    return const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
  }

  CurrentWeather data = (GetIt.I.get<Api>()).data;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(data.date);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                data.iconUrl,
              ),
              Text(
                (data.temp).toString() + 'ºC',
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
                          Text((data.maxTemp).toString() + 'º C',
                              style: textStyle()),
                          Text((data.minTemp).toString() + 'º C',
                              style: textStyle()),
                          Text((data.wind).toString() + ' km/h',
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
                          Text((data.pressure).toString() + ' hPa',
                              style: textStyle()),
                          Text((data.humidity).toString() + '%',
                              style: textStyle()),
                          Text(
                              ((date.hour < 10)
                                      ? '0' + date.hour.toString()
                                      : date.hour.toString()) +
                                  ':' +
                                  ((date.minute < 10)
                                      ? '0' + date.minute.toString()
                                      : date.minute.toString()),
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
