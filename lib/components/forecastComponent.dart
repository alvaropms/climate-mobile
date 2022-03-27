import 'package:flutter/material.dart';

class forecastComponent extends StatefulWidget {
  const forecastComponent({Key? key, required this.data}) : super(key: key);

  final Map data;

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
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                formatDate(widget.data['date']),
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
                    widget.data['day']['maxtemp_c'].toString() + 'º C',
                    style: textStyle(),
                  ),
                  Text(
                    widget.data['day']['mintemp_c'].toString() + 'º C',
                    style: textStyle(),
                  )
                ],
              ),
              Column(
                children: [
                  Image.network(
                      'https:' + widget.data['day']['condition']['icon'])
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.data['day']['condition']['text'],
                style: textStyle(),
              )
            ],
          )
        ],
      ),
    );
  }
}
