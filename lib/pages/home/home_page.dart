import 'package:climate_mobile/components/card_component.dart';
import 'package:climate_mobile/components/forecast_component.dart';
import 'package:climate_mobile/components/main_component.dart';
import 'package:climate_mobile/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Api services = GetIt.I.get<Api>();

  @override
  void initState() {
    services.getWeatherData().catchError((err) {
      services.errorDialog(context);
    });
    super.initState();
  }

  _changeCity(String city) {
    services.getWeatherDataByCity(city).catchError((err) {
      services.errorDialog(context);
    });
  }

  List<Widget> listElements() {
    if (services.isLoading) {
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
                  'Tempo agora em ' + (services.data.city),
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Text(
                services.data.country,
                style: const TextStyle(fontSize: 10),
              )
            ],
          )),
      const CardComponent(
        child: MainComponent(),
      ),
      const CardComponent(child: ForecastComponent(day: 0)),
      const CardComponent(
          child: ForecastComponent(
        day: 0,
      )),
      const CardComponent(child: ForecastComponent(day: 2))
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
        Observer(
          builder: (_) => SliverList(
            delegate: SliverChildListDelegate(listElements()),
          ),
        ),
      ],
    );
  }
}
