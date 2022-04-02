import 'package:climate_mobile/components/cardComponent.dart';
import 'package:climate_mobile/components/forecastComponent.dart';
import 'package:climate_mobile/components/mainComponent.dart';
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
  Map data = {};
  Api services = Api();

  @override
  void initState() {
    var response = services.getWeatherData();
    response.then((value) {
      setState(() {
        data = value.data;
        services.country = data['location']['country'];
        isLoading = false;
      });
    }).catchError((e) {
      services.errorDialog(context);
    });
    super.initState();
  }

  changeCity(String city) {
    String aux = services.city;
    setState(() {
      isLoading = true;
    });
    services.getWeatherDataByCity(city).catchError((e) {
      setState(() {
        services.city = aux;
        isLoading = false;
      });
      services.errorDialog(context);
    }).then((value) {
      setState(() {
        data = value.data;
        services.country = data['location']['country'];
        isLoading = false;
      });
    });
  }

  List<Widget> listElements() {
    if (!isLoading) {
      return [
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Tempo agora em ' + services.city,
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  services.country,
                  style: const TextStyle(fontSize: 10),
                )
              ],
            )),
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
                  onSubmitted: changeCity,
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
