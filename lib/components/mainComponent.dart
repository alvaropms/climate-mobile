import 'package:climate_mobile/models/currentWeather.dart';
import 'package:flutter/material.dart';

class mainComponent extends StatefulWidget {
  const mainComponent({Key? key, required this.data}) : super(key: key);

  final CurrentWeather data;

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
    var date = DateTime.fromMillisecondsSinceEpoch(widget.data.date);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                widget.data.iconUrl,
              ),
              Text(
                (widget.data.temp).toString() + 'ºC',
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
                  widget.data.condition,
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
                          Text((widget.data.maxTemp).toString() + 'º C',
                              style: textStyle()),
                          Text((widget.data.minTemp).toString() + 'º C',
                              style: textStyle()),
                          Text((widget.data.wind).toString() + ' km/h',
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
                          Text((widget.data.pressure).toString() + ' hPa',
                              style: textStyle()),
                          Text((widget.data.humidity).toString() + '%',
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
